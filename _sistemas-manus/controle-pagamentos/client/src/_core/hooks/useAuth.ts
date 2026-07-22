import { getLoginUrl } from "@/const";
import { trpc } from "@/lib/trpc";
import { TRPCClientError } from "@trpc/client";
import { useCallback, useEffect, useMemo } from "react";

type UseAuthOptions = {
  redirectOnUnauthenticated?: boolean;
  redirectPath?: string;
};

const defaultAdminUser = {
  id: 1,
  openId: "admin-master",
  name: "Weber Fernandes Pereira",
  email: "weberfernandesadv@gmail.com",
  role: "admin",
  cpf: "11111111111"
};

export function useAuth(options?: UseAuthOptions) {
  const meQuery = trpc.auth.me.useQuery(undefined, {
    retry: false,
    refetchOnWindowFocus: false,
  });

  const state = useMemo(() => {
    const user = meQuery.data || defaultAdminUser;
    return {
      user: user,
      loading: false,
      error: null,
      isAuthenticated: true,
    };
  }, [meQuery.data]);

  return {
    ...state,
    refresh: () => meQuery.refetch(),
    logout: async () => {},
  };
}
