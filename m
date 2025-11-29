Return-Path: <dmaengine+bounces-7386-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B88C941F0
	for <lists+dmaengine@lfdr.de>; Sat, 29 Nov 2025 17:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF9613A635E
	for <lists+dmaengine@lfdr.de>; Sat, 29 Nov 2025 16:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8BE23E356;
	Sat, 29 Nov 2025 16:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="EAs8TWPn"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011070.outbound.protection.outlook.com [40.107.74.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A67219319;
	Sat, 29 Nov 2025 16:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764432266; cv=fail; b=XQZpB/FuKC3DW50PDpN7pUPm3tJf1udDI56qeUbEud/YLtCcTACZf7YAX17+Ptbt0++reI1E9pwAl7ychwwuRPw1tdQY9Qu2fNpakhBdd6U4v5x6xjTkmZQ0x1rQE95oBRsTsY83PY7qDZSO8cJ0ZHa3PMbeO8ENsaBEgbkyX0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764432266; c=relaxed/simple;
	bh=K+pMQ/p6krojqzS0guF3KlvzdcMv1m56gz/LrJp7s8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iEFkgpCEIEsFib4LsC6kyIKLfKm1I7Y0VUD/H1U8FXVZXIAa07j5dBrw5WgBKuloFAzQpLLTM6GkH2lINaJm0oJNhaMvusckNNYJKVs20hatLSabpj8QwlIClgigb9Cb2AUjlStW8cAPU4yYNEyd7tXFR0s02AhTd1Ft3Eq9gNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=EAs8TWPn; arc=fail smtp.client-ip=40.107.74.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FJejX7+ojQZlVyPd6fPkiM5LUuVwzdOINk/eCeSmuI528aQ9vjzxwLnKdaAWctA11X1dGKZAuKKkISm+B8Bg9LwO4SoYyUU2pd7JVKXafq8T6F3jWMIVCbCFsCZhXuOqzZUMSPlg5+Xj14wD7YQwn5xn++wqxZUDtacpXZZZgIT3dDdyjqP8yLRjkf1e6C1ifL17euqeceoxD0o3+CChJAkHjgQ9bgRZop1KylUKMuQDsR0KD/rHKraPRpvTD4/9f3lVB4pCevlROaEzUHB0Z0JI79lEuQJsg4zddfJt4YsT8lzx95km9gLEDLz3I1ZYkBE/LWa4BiA+Pn9B14s9sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b79E9xLIfHoXYn55+Zf2j9iULT1gaaKpi+zZt6BNr8o=;
 b=d5B3YKPAbtt2Mg+I7k5D1Pjnfk6JHjrmS7B7r3XBPQjyL4nl8wOt/cPO0yNdVueltSqQ4UNYGGnUZilGoImlokYTKysoGseHljm+cNtMnOwBHacpz6XuWIIX3OaN5RvCgjVjmvBbnwKFCwNDlA+ke6y102wWa9cTRXH0+dgd9eIYg/b7KPjx2CaX1ZxJ+igqfaig4J+KLxbP0aV0ehtxpOL4t28+ZI7qB6daHSx8oHDgU/Ss/8kdMRhQsVpf1KEIomBLLOHpBYwx73TklAJ6sMTmiC0qrgL1Eq+CcDyOhaWms5kLThEjd5TucVJdcj/ICoJmc4cvespVEeyl2lPxag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b79E9xLIfHoXYn55+Zf2j9iULT1gaaKpi+zZt6BNr8o=;
 b=EAs8TWPnV9Ff1mob8YYbWp8BdG9j618UqVWQd2beGLGglOAaRepEX77tWjNkD12xWZjvJBSHomkFxLyMkbNj2p3qOqfZUi/ZstY+mWm8MfKbfqCdkBLVwFYnBp3SZ4qVPGmxXXFVOJzEO0Pm3muPWuBUs/GSBIOW95Kd7m5aqbU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by TYCP286MB2050.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:15e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sat, 29 Nov
 2025 16:04:20 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Sat, 29 Nov 2025
 16:04:20 +0000
From: Koichiro Den <den@valinux.co.jp>
To: ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Frank.Li@nxp.com
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
	fancer.lancer@gmail.com,
	arnd@arndb.de,
	pstanner@redhat.com,
	elfring@users.sourceforge.net
Subject: [RFC PATCH v2 02/27] PCI: endpoint: pci-epf-vntb: Add mwN_offset configfs attributes
Date: Sun, 30 Nov 2025 01:03:40 +0900
Message-ID: <20251129160405.2568284-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251129160405.2568284-1-den@valinux.co.jp>
References: <20251129160405.2568284-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0284.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::15) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|TYCP286MB2050:EE_
X-MS-Office365-Filtering-Correlation-Id: 903910ca-880a-41d5-acd3-08de2f60f4b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1lgIM/0SK+gdxT/AvDQUJ3EweEuqXOhtV58oKEcWSoxFIHc6x0OkBgm6SRSv?=
 =?us-ascii?Q?3coh6vkNnFFVOCpLbs4OO69gCMmGXIuHNgTSAQjepMUgvt0ZZbfZCT45asF2?=
 =?us-ascii?Q?giDHH9ZOkO29bOK4WD2QrLmtfE2q3t038PRFmoWXNDc5yMx3ibSuE2Y8iE9s?=
 =?us-ascii?Q?pWFYIAAna/Hqkb5WYoB+CROY3lTmK3U2VCruNwWbJzOe+9GPOCiVtUl1ZZAm?=
 =?us-ascii?Q?6dr+JCQMNtfQokxIwzA6hYjKYN4u3lAaND0sy1ZKWqso869THAvWGMAIhljQ?=
 =?us-ascii?Q?YkEdtk6oFY4zdeRdNBwzxfWOUYoDb+TElwdkG6rBDnCeT42YtFLMZ/dM57P1?=
 =?us-ascii?Q?IF7hDadTduGFw/hba6l56Z2w66foCIWgaMGgj3tA/+giKzdvSf4E+TOtQWWS?=
 =?us-ascii?Q?7t9p1abY6mdb/pHKO4CtbP+HkaE1e9VXNCkzL/xYzqcKKjsBCwgye5XuE2wR?=
 =?us-ascii?Q?oLrab3CI7mZXPCOeHrJcclBfscptjiDtt0sMRhJLmNsewrZlMYc9TEkpTdbX?=
 =?us-ascii?Q?3sonmTBZJK+hx+kx9r1opVK+OOPXA9F3Pl6fucweOWcz7NGWhonVITKaupDi?=
 =?us-ascii?Q?Cmsam5QMwEbSP/oavssA3MKEa08zlIMTTzDvB+CTAq3+7trWQ1gxQfDq9FhW?=
 =?us-ascii?Q?Fis7bQ4wW7i6NjH1Bt2JcxxygLfp30AvDwJdbmnQXYAGqLcks3i3CjG7SFV5?=
 =?us-ascii?Q?PkTfRrpzw3z2bqUbgrLARcfFtFS+twCGImg0W9OIpca51U3eOYIk/udg85Sh?=
 =?us-ascii?Q?kIO/Pm+YR+shqvGS4xc1kXX2SzY2hJL9RfAj4ygDeC99WYtAH5vqLz9+Hs3W?=
 =?us-ascii?Q?R76vmiHejsJfqSM7iknuSvy9bw/Yhgnw0g7gpQB+isHGkXpH3YKBf3inQvQ0?=
 =?us-ascii?Q?ocN/X4jlYTkWr+rAXW3CLdGjJPU4MbiuVmKvbQgvkVDR1ndY4/mEOaT28UVI?=
 =?us-ascii?Q?UvBHSMmGQ3ym2wluhR9vFTcgm/YkfXqx11PK3Uo0zlV9PQI2LS7hGRVU4MpK?=
 =?us-ascii?Q?W+6ilfWB76+fCk7OS7PDJolLmcePx93uDqmJ5uo/uv9BM65xuWY5WpfGghK8?=
 =?us-ascii?Q?emKlBc81xmIPMVR0Mo8AaMnfYb5mtBOP0k3r87u7UUP60S7fXDb3+08kDVGx?=
 =?us-ascii?Q?iLmuN0UWJ8gvz80939ZeRyC3teC7E9QBblNj7vzdzak3GRf1TPm+AvAM1j7e?=
 =?us-ascii?Q?LE5BvD+QIAMWiyGLLNrtu/sRANXcHyZOAQyahWf/ZTdtiF0OHfA+ZN92GnHZ?=
 =?us-ascii?Q?ubdekwYrnIxmT1PQfapNfRnxH3tws0yTZfdgk3jGPLM0uPsW/SfuNrQrzY8S?=
 =?us-ascii?Q?Ge2Uqd151tGqzpVn10UIJYRebAA57BrY9d9amsZCiKC/SpzJcnBl5hBKluPC?=
 =?us-ascii?Q?FMQZKLLMgDDw3Ms4QmF/xwo5gf/Hc0fIgQy4D6WEgGFBnFsRjBbB/5QOvV3c?=
 =?us-ascii?Q?/WuZRnRPEfAjRHGw0dtRcYQ5jCzdzCt1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sJ0xcoJbi51mzu9YDaESn548FULvo1zZUkTNuyPdiXfzL5SxJzE38E2q+RfD?=
 =?us-ascii?Q?8W2eWSrqpVhIsdgw3wYWE+T+gS1RHbyf5CpmDxKO19OaJYaN/Lw3OitaIpby?=
 =?us-ascii?Q?UJcFkBnMlr02lXPirFIELdcX9VxiVspyKz8k40fH0BhfCW5hNi2119C8UdoX?=
 =?us-ascii?Q?YXcx62fvi6Zjqe2KrxMmlCqRKXvppu4drApxHKhaCzkM8agzpuqVvcEvj6d/?=
 =?us-ascii?Q?XpS07A8xKPa1Fpm1taD2H3HsHZc2UbSbNIA4Uoea5brw6EZn9sUrntvkY3e2?=
 =?us-ascii?Q?ka6zmsnXJ0JW6I7M6eR79W7HP+Br6/gVq/uGiOeQe8EsEUvk7FEAZczjp/pU?=
 =?us-ascii?Q?YzcJCk+b6TrT30ZoGmY2n44dXvA9qn0+HxsAlxE5hJ2M48YFb2AQ1WK/qqwa?=
 =?us-ascii?Q?ygz50Yevr2aSynNpnwlnqA895QYHAbSWrZWDAsiBMZRhV0wEqJ0lQgo/FxEc?=
 =?us-ascii?Q?BzarPYUW51VaqUjU94mwiJWBdIXx7ZAAieJz1BdpaRzvPGnWQUOdv7Mp6q9/?=
 =?us-ascii?Q?H5B6gWveH+ojM+EIrlHRmRJXr13txCNmCgR6gGsYlcLDRHuSarNxJyDyqq6c?=
 =?us-ascii?Q?9lRpVYZK176VvK1kJaihXRoPSx99WXaa08A+8eGb4j4rdTt/TxPMMb3AyZhE?=
 =?us-ascii?Q?UvXJEGiinBLc00+6cAqirvZZ3hFrsJjEUW5sygndY0EkrAn5mJunxkgdiwqM?=
 =?us-ascii?Q?oBEpbWUy6GEXCumKCL42uID/4jqetTOGmuTcnNXKoLy8Sku3AUgD9rV00beB?=
 =?us-ascii?Q?OFMdQiR5A5rqJis5o8817VzfwHEuO0f4UWcN6Ewrxwt0fF8PwuGj6yqkH/JS?=
 =?us-ascii?Q?chdVTmP5oWExfLYBI6q8pmqNsxuoLxy9E8q5scAjVFVauY8JsW5dWxe5vYPf?=
 =?us-ascii?Q?oOfgXCoZshX84BdZ+qs0XQjBUqnvaJpgGwocfHqVVaCwHxXGjEJbEBGTaGaZ?=
 =?us-ascii?Q?6q8jI3uK1Wv6bjUBBoY9wdID6yrdgKsfMgKr9E3JQaQfmzBjkwxsHkEDtCAi?=
 =?us-ascii?Q?0HwXd2bu7FVQIAPUtk7EplPsKysE04jdpSixQhx2ywEQu6UMy4Fp/UheWlj3?=
 =?us-ascii?Q?IEDoM/W4T1dFn+yrySUoZaryEp0dIMnvOYhdB/BE4Dzn9GRxaxh3BbnvDuzj?=
 =?us-ascii?Q?VfEXHddXAmgWtQvEiicENQ/u+TMtZCgwJId4ZEAsfYAhcdG5F7gP8nEHkSwL?=
 =?us-ascii?Q?XBNlh3+mghXmGIUrwSdSi0GfKmkd7Sa7n5M/MWFHgfcqdndXhP98BAL4/MbG?=
 =?us-ascii?Q?bWme2f4o+WG+Uj91FPvU5uJkkjxhWimFEXwzDgtRbN8CuzGisrOHs73lC5b8?=
 =?us-ascii?Q?dFPWnvlvAhx9fbHT8+QKxGCKdAPczv5rGZBYv5nmFi0O+nYzbGl4joF4gOuY?=
 =?us-ascii?Q?5iSJ2agbH2XRdA39y4LLt4EIK01g1mah3DxP8q55F2/N8s6TKmvWmYpJeVVw?=
 =?us-ascii?Q?RTNK3uPcQ6bm710IG28MYn/Cbq/M6InSU1kRSMzWyH69QMCCJf2HMXIeEAuQ?=
 =?us-ascii?Q?CJgYEwfFxjrnJ5kAHj+vt8f06cmJOBfl3mDgq72DThNSY7pYbB3nhYibeTfU?=
 =?us-ascii?Q?guTYxjzRzNhSfkT8+ySlOOEjN1bxPh2ikxDxG6xEEXwBSBkrO+VKEuVye//2?=
 =?us-ascii?Q?wRq6z/rp8tLWE44IWj9VTqo=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 903910ca-880a-41d5-acd3-08de2f60f4b4
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2025 16:04:20.2688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uJH3oovu69SMEL2DF4M9Lmg6/udCQpMjZCGUnTcpHoYQpqGluTfJNPAh/FJ30BcetDl5IH6ScXUdB80GYm2uHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2050

Introduce new mwN_offset configfs attributes to specify memory window
offsets. This enables mapping multiple windows into a single BAR at
arbitrary offsets, improving layout flexibility.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 133 ++++++++++++++++--
 1 file changed, 120 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 6c4c78915970..1ff414703566 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -39,6 +39,7 @@
 #include <linux/atomic.h>
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/log2.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 
@@ -111,7 +112,8 @@ struct epf_ntb_ctrl {
 	u64 addr;
 	u64 size;
 	u32 num_mws;
-	u32 reserved;
+	u32 mw_offset[MAX_MW];
+	u32 mw_size[MAX_MW];
 	u32 spad_offset;
 	u32 spad_count;
 	u32 db_entry_size;
@@ -128,6 +130,7 @@ struct epf_ntb {
 	u32 db_count;
 	u32 spad_count;
 	u64 mws_size[MAX_MW];
+	u64 mws_offset[MAX_MW];
 	atomic64_t db;
 	u32 vbus_number;
 	u16 vntb_pid;
@@ -458,6 +461,8 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 
 	ctrl->spad_count = spad_count;
 	ctrl->num_mws = ntb->num_mws;
+	memset(ctrl->mw_offset, 0, sizeof(ctrl->mw_offset));
+	memset(ctrl->mw_size, 0, sizeof(ctrl->mw_size));
 	ntb->spad_size = spad_size;
 
 	ctrl->db_entry_size = sizeof(u32);
@@ -689,15 +694,31 @@ static void epf_ntb_db_bar_clear(struct epf_ntb *ntb)
  */
 static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
 {
+	struct device *dev = &ntb->epf->dev;
+	u64 bar_ends[BAR_5 + 1] = { 0 };
+	unsigned long bars_used = 0;
+	enum pci_barno barno;
+	u64 off, size, end;
 	int ret = 0;
 	int i;
-	u64 size;
-	enum pci_barno barno;
-	struct device *dev = &ntb->epf->dev;
 
 	for (i = 0; i < ntb->num_mws; i++) {
-		size = ntb->mws_size[i];
 		barno = ntb->epf_ntb_bar[BAR_MW1 + i];
+		off = ntb->mws_offset[i];
+		size = ntb->mws_size[i];
+		end = off + size;
+		if (end > bar_ends[barno])
+			bar_ends[barno] = end;
+		bars_used |= BIT(barno);
+	}
+
+	for (barno = BAR_0; barno <= BAR_5; barno++) {
+		if (!(bars_used & BIT(barno)))
+			continue;
+		if (bar_ends[barno] < SZ_4K)
+			size = SZ_4K;
+		else
+			size = roundup_pow_of_two(bar_ends[barno]);
 
 		ntb->epf->bar[barno].barno = barno;
 		ntb->epf->bar[barno].size = size;
@@ -713,8 +734,12 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
 				      &ntb->epf->bar[barno]);
 		if (ret) {
 			dev_err(dev, "MW set failed\n");
-			goto err_alloc_mem;
+			goto err_set_bar;
 		}
+	}
+
+	for (i = 0; i < ntb->num_mws; i++) {
+		size = ntb->mws_size[i];
 
 		/* Allocate EPC outbound memory windows to vpci vntb device */
 		ntb->vpci_mw_addr[i] = pci_epc_mem_alloc_addr(ntb->epf->epc,
@@ -723,19 +748,31 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
 		if (!ntb->vpci_mw_addr[i]) {
 			ret = -ENOMEM;
 			dev_err(dev, "Failed to allocate source address\n");
-			goto err_set_bar;
+			goto err_alloc_mem;
 		}
 	}
 
+	for (i = 0; i < ntb->num_mws; i++) {
+		ntb->reg->mw_offset[i] = (u32)ntb->mws_offset[i];
+		ntb->reg->mw_size[i] = (u32)ntb->mws_size[i];
+	}
+
 	return ret;
 
-err_set_bar:
-	pci_epc_clear_bar(ntb->epf->epc,
-			  ntb->epf->func_no,
-			  ntb->epf->vfunc_no,
-			  &ntb->epf->bar[barno]);
 err_alloc_mem:
-	epf_ntb_mw_bar_clear(ntb, i);
+	while (--i >= 0)
+		pci_epc_mem_free_addr(ntb->epf->epc,
+				      ntb->vpci_mw_phy[i],
+				      ntb->vpci_mw_addr[i],
+				      ntb->mws_size[i]);
+err_set_bar:
+	while (--barno >= BAR_0)
+		if (bars_used & BIT(barno))
+			pci_epc_clear_bar(ntb->epf->epc,
+					  ntb->epf->func_no,
+					  ntb->epf->vfunc_no,
+					  &ntb->epf->bar[barno]);
+
 	return ret;
 }
 
@@ -1039,6 +1076,60 @@ static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
 	return len;							\
 }
 
+#define EPF_NTB_MW_OFF_R(_name)						\
+static ssize_t epf_ntb_##_name##_show(struct config_item *item,		\
+				      char *page)			\
+{									\
+	struct config_group *group = to_config_group(item);		\
+	struct epf_ntb *ntb = to_epf_ntb(group);			\
+	struct device *dev = &ntb->epf->dev;				\
+	int win_no, idx;						\
+									\
+	if (sscanf(#_name, "mw%d_offset", &win_no) != 1)		\
+		return -EINVAL;						\
+									\
+	idx = win_no - 1;						\
+	if (idx < 0 || idx >= ntb->num_mws) {				\
+		dev_err(dev, "MW%d out of range (num_mws=%d)\n",	\
+			win_no, ntb->num_mws);				\
+		return -EINVAL;						\
+	}								\
+									\
+	idx = array_index_nospec(idx, ntb->num_mws);			\
+	return sprintf(page, "%lld\n", ntb->mws_offset[idx]);		\
+}
+
+#define EPF_NTB_MW_OFF_W(_name)						\
+static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
+				       const char *page, size_t len)	\
+{									\
+	struct config_group *group = to_config_group(item);		\
+	struct epf_ntb *ntb = to_epf_ntb(group);			\
+	struct device *dev = &ntb->epf->dev;				\
+	int win_no, idx;						\
+	u64 val;							\
+	int ret;							\
+									\
+	ret = kstrtou64(page, 0, &val);					\
+	if (ret)							\
+		return ret;						\
+									\
+	if (sscanf(#_name, "mw%d_offset", &win_no) != 1)		\
+		return -EINVAL;						\
+									\
+	idx = win_no - 1;						\
+	if (idx < 0 || idx >= ntb->num_mws) {				\
+		dev_err(dev, "MW%d out of range (num_mws=%d)\n",	\
+			win_no, ntb->num_mws);				\
+		return -EINVAL;						\
+	}								\
+									\
+	idx = array_index_nospec(idx, ntb->num_mws);			\
+	ntb->mws_offset[idx] = val;					\
+									\
+	return len;							\
+}
+
 #define EPF_NTB_BAR_R(_name, _id)					\
 	static ssize_t epf_ntb_##_name##_show(struct config_item *item,	\
 					      char *page)		\
@@ -1109,6 +1200,14 @@ EPF_NTB_MW_R(mw3)
 EPF_NTB_MW_W(mw3)
 EPF_NTB_MW_R(mw4)
 EPF_NTB_MW_W(mw4)
+EPF_NTB_MW_OFF_R(mw1_offset)
+EPF_NTB_MW_OFF_W(mw1_offset)
+EPF_NTB_MW_OFF_R(mw2_offset)
+EPF_NTB_MW_OFF_W(mw2_offset)
+EPF_NTB_MW_OFF_R(mw3_offset)
+EPF_NTB_MW_OFF_W(mw3_offset)
+EPF_NTB_MW_OFF_R(mw4_offset)
+EPF_NTB_MW_OFF_W(mw4_offset)
 EPF_NTB_BAR_R(ctrl_bar, BAR_CONFIG)
 EPF_NTB_BAR_W(ctrl_bar, BAR_CONFIG)
 EPF_NTB_BAR_R(db_bar, BAR_DB)
@@ -1129,6 +1228,10 @@ CONFIGFS_ATTR(epf_ntb_, mw1);
 CONFIGFS_ATTR(epf_ntb_, mw2);
 CONFIGFS_ATTR(epf_ntb_, mw3);
 CONFIGFS_ATTR(epf_ntb_, mw4);
+CONFIGFS_ATTR(epf_ntb_, mw1_offset);
+CONFIGFS_ATTR(epf_ntb_, mw2_offset);
+CONFIGFS_ATTR(epf_ntb_, mw3_offset);
+CONFIGFS_ATTR(epf_ntb_, mw4_offset);
 CONFIGFS_ATTR(epf_ntb_, vbus_number);
 CONFIGFS_ATTR(epf_ntb_, vntb_pid);
 CONFIGFS_ATTR(epf_ntb_, vntb_vid);
@@ -1147,6 +1250,10 @@ static struct configfs_attribute *epf_ntb_attrs[] = {
 	&epf_ntb_attr_mw2,
 	&epf_ntb_attr_mw3,
 	&epf_ntb_attr_mw4,
+	&epf_ntb_attr_mw1_offset,
+	&epf_ntb_attr_mw2_offset,
+	&epf_ntb_attr_mw3_offset,
+	&epf_ntb_attr_mw4_offset,
 	&epf_ntb_attr_vbus_number,
 	&epf_ntb_attr_vntb_pid,
 	&epf_ntb_attr_vntb_vid,
-- 
2.48.1


