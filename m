Return-Path: <dmaengine+bounces-6945-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CCABFF8F1
	for <lists+dmaengine@lfdr.de>; Thu, 23 Oct 2025 09:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 95A444E06E3
	for <lists+dmaengine@lfdr.de>; Thu, 23 Oct 2025 07:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB912F0C67;
	Thu, 23 Oct 2025 07:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="F+rh+5iJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011034.outbound.protection.outlook.com [40.107.74.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEF52ECD11;
	Thu, 23 Oct 2025 07:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203981; cv=fail; b=MHxba9jjOa6D6O1i5mwkKQiLT6AENWNz5U7x36oQhiZvmE5aiByBlzBkO2ZKJ+kxdI+OqDqRRAZbLp+KpcQdsMi22mAF4QtzoLgi8C15FQYqg+M1JfeY5k1LQJFKoHK762Ksona0mkpMH7kz9RjNzdOQttoivK65oLcBzDiwp5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203981; c=relaxed/simple;
	bh=4Nsdu79aziDcJLE8+M0S3cgONT5qDqao1bUSVt0K1SU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oY7sUxW7mIouxSKZjVNFOhy7PBrm3+xby/leZUQRXIeShgzugBtiKSYrr4nAM7qfQg99N2XJEuzAmOBGcWzrN0YY0k9FkRVsChzq8k4K26WOPtQ/QWV1qMCMWgXD/G35hF8TxtmObajmAUE9PggNOC23CwF+QKXXNEHlPp1hP0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=F+rh+5iJ; arc=fail smtp.client-ip=40.107.74.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G13K60sgGFXYVDJVskGhEKiN5viXnkw5HGUBXAq/sDSFRhQi8ktaO/oOfszpPQEXamKCZlf4iQVI4Fd1pbKYVrzDP7xBeCfcBqxtoehfiTIdACcLVPnp5KhEymP/Q7/uB46ROqu5TfPk07OM8WLxuz4U0CuYgMs3HaF9CCzFUKKGA7cB+zHDWbncnb9iCjY095TaBiWC0+IgAUcIm+n/yaUsetRTeF13XvDU/F6TLd3SBWGWP+QOKtoazpLnNPZ6ZLm1OUnGSy0MSTITkGRxCxl3xI1IZ5DOuDkM72xkqLxH6Vm0SwkOOQhJ1+XKRgvaDVO9hrjHTCq7OX/pikuGiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9qA7+NI+VnmCR2N9NuCdGvwrWGoXLdq24Cu//UtkPI=;
 b=JBdDEPYKjQuL1t728wwg+kJuBXRohCMHMaY3D8o+LwvpYdGNywqlJvTuQq8yAgw4dhzzDo6TV9VGZstR0j4zgfZxVNl4RYCuEcNWeBX/P+8z8tTpXOHq4rPlu2o3ZqY1vAhqD7WkT2rduzFpjBVLewxVXdunpbF/1oOU1PPRS8jdxFH+aNs72+s5na9H8p4KI8PnWN4VXDZLgC2Ztkn83oIcvHqP8X8FIxHqsp+dDqK5bfYbkjMwnIxAjFCRgqnu7auDQKnHAWQn/Izc6NpTQcmiBuRg947rvtSRHk2YWgJR6e+8T8EY1Gm0IDOICsowSSwPdVn9hcYNbbBd4GjNiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9qA7+NI+VnmCR2N9NuCdGvwrWGoXLdq24Cu//UtkPI=;
 b=F+rh+5iJYM7vm5UHCkMaQ5VDLSlt8J7iKk6V4O4qXiJY9cl+OAiMoCpq5WCpwNH0675jZobS/EJKetoONglxOhg5YDhO9ZBUwVk1OUX9KEUdug4mljFwKqM/R0s7N6MZgOk4DUJt6A/00ers9S8NFn0dKkyUsjuTvo0vj+PSHFk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10d::7)
 by OS7P286MB7183.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:456::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 07:19:35 +0000
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a]) by OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a%5]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 07:19:34 +0000
From: Koichiro Den <den@valinux.co.jp>
To: ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	corbet@lwn.net,
	vkoul@kernel.org,
	jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	Basavaraj.Natikar@amd.com,
	Shyam-sundar.S-k@amd.com,
	kurt.schwemmer@microsemi.com,
	logang@deltatee.com,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	robh@kernel.org,
	jbrunet@baylibre.com,
	Frank.Li@nxp.com,
	fancer.lancer@gmail.com,
	arnd@arndb.de,
	pstanner@redhat.com,
	elfring@users.sourceforge.net
Subject: [RFC PATCH 10/25] NTB/msi: Support offsetted partial memory window for MSI
Date: Thu, 23 Oct 2025 16:19:01 +0900
Message-ID: <20251023071916.901355-11-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251023071916.901355-1-den@valinux.co.jp>
References: <20251023071916.901355-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0290.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::7) To OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:10d::7)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0979:EE_|OS7P286MB7183:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e7c99c7-dde8-4feb-7633-08de120484ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BJN1uctNrF/ZwFTCi2FcCaS75H6lessMNC0DEpb2lJzwTkOy4BZLX6Gc8tBb?=
 =?us-ascii?Q?+bXTOVpqY3XdQXcA/1Vt1no3WmC/gFAh5xbXmMG9qnEnZ/SK+9n4r9Bhh8UG?=
 =?us-ascii?Q?fTJK1lnw868zfLos88PtlKUUMox++F0qTcFCqvkEYssSBDigxJmD6P7bQz/F?=
 =?us-ascii?Q?Ee58p7egp0eIjMm71tWdl/q8TyHWa05htnZ/DaAviJnU+xyOfM5dnWo/3gVg?=
 =?us-ascii?Q?xnM++DgnBS6Et+XBdbqCaUU4jIZbaTUxDoI6n4whqaZnXYFmtcFPdoHyncjY?=
 =?us-ascii?Q?C3O8IU4NHxTlKban7VQ1vAdV8wMy7P99b5pj7k4moWaNI5ZtuBgz0r9PxCgH?=
 =?us-ascii?Q?HPNP3JqaGhB5zKLm3JiyNBXz+nvU5DJe4ROJSCxW1NBi4NCQTi7mva+8EyeQ?=
 =?us-ascii?Q?YC10sNS6Um8lbqjFQ5Lg/21WN4eAKoCC9BHPh+2k2TsXngsnwSG3wsXrHswT?=
 =?us-ascii?Q?jXvfzTunS6+v+LNypvKhXdwjpD947WScMtF/aZ4kl0D0yeyfI80jw/baLdaL?=
 =?us-ascii?Q?2d4vD83y2iR4gPr3blVXDfpAq4bX8qJKSPV9sYph/011Hz6gw4Kds2NWJZLC?=
 =?us-ascii?Q?CMGIZT4WWh5Cgst555FQm+Jb2RPpauXj9X0Es6rN5GfEXeors0LjV7erTMoA?=
 =?us-ascii?Q?S/TnP6ceREXKUsa4yWqIr//6Mcxwy1N0zjNYyP8xk7IxzXQgucYEAq8XemiC?=
 =?us-ascii?Q?Gz3QT89Tcw3PhJuiXfYaEXJy5kHbw3m9KUQx+qCs4SYSwfwNxNmffHGzxsAt?=
 =?us-ascii?Q?4NGOJBfsmHmfqPf+SLX2NAxPqHBunTSxQP7zu3wvQIVeek40lR+D7soHZCit?=
 =?us-ascii?Q?cUalB8hH17ubKRvel4IeF6CkdyVY3FG5BRqARdqJJBvtgjEKJbPSVGD0Hr3Q?=
 =?us-ascii?Q?ncSlx4kzIFC+I2X252JAXWb2f5zySbnuc5JTYC/F4+onEvG5PI+RE4hyIAMo?=
 =?us-ascii?Q?VC3Vw+ZO6c66yXNXygV0BfgILMStXopCcx1Hs2GIbDY41ah9oxVAvWtEYOiu?=
 =?us-ascii?Q?hIpbk1vWmF1u1n+XD3SSBMgLWTuk4z60KZOlK51HlIbH6nGIxG2Gc9ctOCpB?=
 =?us-ascii?Q?GZHMEBSNYqhSm2PxtLwjg8DSJ5PZPwsr8Ol9ngP8STO2pPJx/7nHDIbbj0CR?=
 =?us-ascii?Q?xuKx1u3CLL0BqSwy7kL2U7jyiMwVu6UNp5OhlCDHSkFuCe+CCjdc75h2S7WB?=
 =?us-ascii?Q?UcYPu0wURvVRoH9iSaWFCV1elLcki1feI6XEZDLOKoJfhpQcCm+V4YDuD8sX?=
 =?us-ascii?Q?GnLJYoE9KCt/fvI7phVt5km5KI0dhLxvX2UoEeIk5IP5g5BmUhsvZllLHueJ?=
 =?us-ascii?Q?xkhKutCRyyVik7WLsR9NrNCVZjXDpntsMzzOZ3pjkcY1hsj+c+Zd+otASM7z?=
 =?us-ascii?Q?ul9a1eaEeasGkEmSIiuCEbib0cRu8P2rDg+m+caKTExAWR0kD31w+Ht6zJEh?=
 =?us-ascii?Q?Wsk76fDjFz9N/ofsAAf53Km6l7qrtPZF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P7lBL9oGTG96Has6u5uXE2r7+q5E7d5WMDRq5M0NIzPlPGPdd1tEStzvM2a0?=
 =?us-ascii?Q?0SlXdrC7rVcWPvh8UEcBjNV4zRz9b0D8G4mg6E1SngtNXryobqX56eh5Oir+?=
 =?us-ascii?Q?ZygfQJxTrs+7/NvoYGdZ9+r7xLJ0V4TZRW48FP8bQu4zWy0baI3HKNA4EDQB?=
 =?us-ascii?Q?Q0NpLXFUVpi3QZPILivGxy4mt2R7E1mvdUt5NARap/qnYj/kMIGFEmFPNaPe?=
 =?us-ascii?Q?7yFVYb/1DozpSVSlD9uRqgKqT0OzoiT87xbePcAOo98PJEYyBZ7LvULF/Bsw?=
 =?us-ascii?Q?/7Sh9CIcqD8rlgXbHV93es/L8NKyIu6rbiQvTTStx4t5Ww9fLptCLi65ctNq?=
 =?us-ascii?Q?NSmHorHmfajxm/HAjqPoRFTQ3y5jkRoxD/Iqvkp1+OVHki6W0GEe5MT2TYyD?=
 =?us-ascii?Q?VZHKRrmoJtarHJ+Et1RUopsmpYqVmvPQ9GCOM6rj0RMXnbC/W6hlCLFLZsrQ?=
 =?us-ascii?Q?RJ8qIBNhD3rio7V96X0PZQe7dprGntNxsZcqiEIyqnTBG6OGIf7sJYsSZMPI?=
 =?us-ascii?Q?PrYTFy7OZWLg1IR3VjC9IIKyEqj/cqTLZmA/3g3gGbBDb+PHmsaPz6ePwtV3?=
 =?us-ascii?Q?aPCwQxcfB28T8ioevots3E47ODQqhHJw1ltdVhFtjECbTfNdn97r242yyUDb?=
 =?us-ascii?Q?I6lGpKaqX72R/yxD4byKSQKpPr5QP4mWlD7k84YyalkG2GnIAeFFhyrbqDHE?=
 =?us-ascii?Q?63ridJiDtav+GCdL8qexdU56L1ezfaxRa96KYMmtCGK9Lq93uppvImSx9jma?=
 =?us-ascii?Q?LDGXdrGvw1s+W7TQXXkofpFtrOAJ0y3qogDGlEyjhwYJ8R9nmXXxaup0NLmd?=
 =?us-ascii?Q?NVqrsZ8rv9rilxxyO9s1hgSvxvhLuF2Gej3AFYsMreIXwRVkoJ7Io2w9PMzu?=
 =?us-ascii?Q?DD2TCfcxjjLAXVTdbE4llUruYHoC8oeIzizJDEPSnCuQn0afQAzfLDCSXKDD?=
 =?us-ascii?Q?jqFSE1wrAKIJD92IHXK0xM9CDhG2g1Sdvfo2b6Puy2ron64ZPFXIXYVQg7R6?=
 =?us-ascii?Q?/sWavLtqqJHxFedKdK3w0BDBOHtsQ8mHhnw3uRaekkTdmHYAyrJOHCd1GGJo?=
 =?us-ascii?Q?LOOPY6D3H8MniXOLxjxAFuOrvPp1QVvzWAiNWqSLdpNlsQMd4bpUn9I/CmoS?=
 =?us-ascii?Q?ReO4wb97kyjKWcSgnWqgFxapgTtLhA4QYMiX7QH4NX9haNsMpiisOkieWQ8t?=
 =?us-ascii?Q?NSAZVBZuIAY1u5SKFw6mR2i/NaKgh68eefC/ov3YWxEsHlPjkyQkjH7eK3KX?=
 =?us-ascii?Q?/WsRMKYpJApUarKdKWPGkL0RLjyEuG+l6wPm8trrpLWuu/jT+lNHoJv9NLPP?=
 =?us-ascii?Q?Xd84xKr2Cmv8TAefaQzIpNCMlQpMEtqLuXSlPbRLuX8yrtReFImMcWOUSJyl?=
 =?us-ascii?Q?m/OJ1xKT0+b9mgnt+RCbSxH63sIzFQL5vXuJ+rfYoJw18oWmsb9c/TTN3nwK?=
 =?us-ascii?Q?Dp719QJrNzXCHs4WXVPhLks+zg3Y3rZTIjWMK1Xe5yGXlfccTscXUtf/ndYd?=
 =?us-ascii?Q?dzafVkmtO3fMUBkLcpXbOs23QfbjliI2+RYSVcqoL5jVennD6FN23UuIIUjI?=
 =?us-ascii?Q?qHbR16ItcXkVfwfr6SvtO7aVeoke2NrGSi6YHhB6hzRG4rUucbmJyXdhzclT?=
 =?us-ascii?Q?3D6QrjggXtlXcrYMdiCir8M=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e7c99c7-dde8-4feb-7633-08de120484ad
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 07:19:34.9393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cQlaezzZo8xoAjAW/KbzaVRcxm7Kzf3Qo88CW4A8t0kxLiMXJKnHR0Pgp2DXYL8RQydgHL2DgaYAT7W3xfoR6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7183

The NTB API functions ntb_mw_set_trans() and ntb_mw_get_align() now
support non-zero MW offsets. Update ntb/msi to make use of this
capability by propagating the alignment offset when setting up a MW
translation for MSI.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/msi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ntb/msi.c b/drivers/ntb/msi.c
index 8875bcbf2ea4..4dc134cf404f 100644
--- a/drivers/ntb/msi.c
+++ b/drivers/ntb/msi.c
@@ -97,7 +97,7 @@ int ntb_msi_setup_mws(struct ntb_dev *ntb)
 	struct msi_desc *desc;
 	u64 addr;
 	int peer, peer_widx;
-	resource_size_t addr_align, size_align, size_max;
+	resource_size_t addr_align, size_align, size_max, offset;
 	resource_size_t mw_size = SZ_32K;
 	resource_size_t mw_min_size = mw_size;
 	int i;
@@ -132,7 +132,7 @@ int ntb_msi_setup_mws(struct ntb_dev *ntb)
 		}
 
 		ret = ntb_mw_get_align(ntb, peer, peer_widx, NULL,
-				       &size_align, &size_max, NULL);
+				       &size_align, &size_max, &offset);
 		if (ret)
 			goto error_out;
 
@@ -142,7 +142,7 @@ int ntb_msi_setup_mws(struct ntb_dev *ntb)
 			mw_min_size = mw_size;
 
 		ret = ntb_mw_set_trans(ntb, peer, peer_widx,
-				       addr, mw_size, 0);
+				       addr, mw_size, offset);
 		if (ret)
 			goto error_out;
 	}
-- 
2.48.1


