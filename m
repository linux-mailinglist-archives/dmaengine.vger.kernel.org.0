Return-Path: <dmaengine+bounces-3781-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7889D7981
	for <lists+dmaengine@lfdr.de>; Mon, 25 Nov 2024 01:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D4A6B21D0D
	for <lists+dmaengine@lfdr.de>; Mon, 25 Nov 2024 00:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44269632;
	Mon, 25 Nov 2024 00:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="DpMvZRrP"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010017.outbound.protection.outlook.com [52.101.228.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA48376;
	Mon, 25 Nov 2024 00:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732495720; cv=fail; b=Ia6mIJkjsA0TjeiSe3uSyYwFeCjTnXN/KFxrtrzEGQ35YdWfMvkKUxDxChG0kOLTZrj4LS3Fpimo4A48gqxtpHbcNjDOb1/Lq5BAztHEuH6wvnMC961z/Vjox29xKu4bIwX7UpXngkEykYzWS7Xo14fgSD6GdyG9bt2nMGa+7R0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732495720; c=relaxed/simple;
	bh=IRUMc/exNoQPH7sc5o4YfId6JpexlhKMngxFpZvJRa4=;
	h=Message-ID:From:Subject:To:Cc:Content-Type:Date:MIME-Version; b=WXA1f/uNzR8KQNRvAZbevooTFFIWH2JU4+NebL8DGoPo8sTo/fDy/SPyPagJQrbSfwqnHgRykho0vj+xO22j/AHIQHf0voKuemJ5Of6JGEo2Ul6cCFOhDFjyFn68omzFAzxT9Sjo5BtdjSBeGmK/hY/VDIAV7Av9oqXPzQ7kD0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=DpMvZRrP; arc=fail smtp.client-ip=52.101.228.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xb6sIqLMDqv8hLDwddkS0BRh2l5AaPH/gCtzxFuRJ9k1UKF6q6mtEInONUe1tVIaKXgrIaykynNxOtnOdEc2xKbdR4KS4pUSg+l+BXY+USxHdZjvzBnppxpY6KsgyeXg+eWUgghWFJ1dVJ2O1GAIsOxxW013DIzKU/fxQ5pCPxts6XS44pKdyswrJSrIXxHsLAbp/EGPlM/yFwnIuyusdU/C5ylWyNR1Kq0ccx9pzEibjXC080w6oF1le9/x+rkzN5v37Ej1QDzUsYTDBIMex6JoQCcCK9a1J4TKDBZsX8hPqdzKzOrmw0CWIaZ5fGfZpSjXHc+oGHo/xyEXtA4l5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QmPeC48+/wGgU0A2SxDrlO+7bAs3Wpoe41PzyUo3ZFo=;
 b=V/plTDU7GMCcy3dy22dPtH+VucMA1CMIq5Sr4rZfC/OEGgIrLhshHdJSY8CIcIx6SFPqu2OGRoKDuz2uuJd7wPLTOm8tF+WbdhEoG/Krdh+0fBRVEYCCPKqe2FSIqAD4ughEMUhcJ8P563qB1981QUhRPUyaLvAdmoo5rtwaoq0leTZfSNWf8tVcHcXIhjW7OWMD0ENQlunOTdGpFAFO/zHoRY7XjJtK3oOym+GIAYXGf7Mo/utnY0ZS+tKKYf58eRHMCDPvymEOfMmoSNYAK1ghYafdywzLjbRLNWS12cduWSbGZYfVV9qFp+b67XMOPdNv72lm88+DurHdDATvUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QmPeC48+/wGgU0A2SxDrlO+7bAs3Wpoe41PzyUo3ZFo=;
 b=DpMvZRrPPeGxlpqfgiC1t9CIjS02i3Jlro1/5Z0ppSSoQb2tYs/4N/7375UFB1VUtLVmDn5+08Sv6SR8GH1Tf2xjJ9a3mJlNjs1LQQXaOfvKmg4U8yTAQbfYDjZATTpQe9+VehXEIOpQFmOV3uCKWLAvEUS4eBjHuuK1dKp3cLI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by OSZPR01MB6247.jpnprd01.prod.outlook.com
 (2603:1096:604:ed::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Mon, 25 Nov
 2024 00:48:33 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%4]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 00:48:33 +0000
Message-ID: <87ttbw3zq7.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH] dmaengine: sh: rcar-dmac: remove r8a779a0 settings
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
To: Vinod Koul <vkoul@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Ulf Hansson <ulf.hansson@linaro.org>, Robin Murphy <robin.murphy@arm.com>
Cc: dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset=US-ASCII
Date: Mon, 25 Nov 2024 00:48:32 +0000
X-ClientProxiedBy: TYCPR01CA0152.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::6) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|OSZPR01MB6247:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e0a733b-c9df-412d-ed11-08dd0ceae334
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t43W3g5c6k5jcmH4hQhasx+clRFfbTq6/8yM60kmFAAXkUiI9fkbOafvdBKr?=
 =?us-ascii?Q?eMlT2+Mx8mKaNmfzT0QRt98ghDw4NxVwkFHYBml4kBLRKxSStSF9EgZG3Rqu?=
 =?us-ascii?Q?7irIAZ68LrLJxefhShV5OEvzb1Iz99310Iqb/9Rg5uDH+kn9vtm8eX6+gyoD?=
 =?us-ascii?Q?qAkLN16GJxWSQKhGYIWewZ3a8hvyNAtyaXqliHbcTU1aiMzhvi7dwgDhu4F3?=
 =?us-ascii?Q?mnZGQLc5IikJ2FYtUv+D5ujrff+5jVBm36+u1ni1UWSk12I+S4JklMrCnxlW?=
 =?us-ascii?Q?E0+joqjt9RRCJ2+i3TgA/ySCNFbjxsTKTojejwX3FH7CQHDNEmg2zbu0Rxp6?=
 =?us-ascii?Q?PTB/KxAQ/dSvYvr2E51namWHvn1wmYxoV8pvmBcm6nrkeVhfS0fK3Iuy2Kf3?=
 =?us-ascii?Q?al1QlqTiTY8EaL/4ZDliAHZx/kd1Qc+Ie4sly0nQT+Harvbr2tkt6KhiHZ+8?=
 =?us-ascii?Q?dYxnSvmfO/M7Wrymgn4LtcGNz7t2xVPpYp/HyMvaIJPUwxvSLJcInOWTUgAE?=
 =?us-ascii?Q?D40ZHzVdRZE6Ds+dGNu0SQE5jsqWxVHL/+EzdLLWZ//DJshb/gHxMAeadI4l?=
 =?us-ascii?Q?qOFnTXl+dUNDudx3UsPDKRIsJnlkx13I4k5pKomPoITgfocW/vI4Td7nfZjG?=
 =?us-ascii?Q?45CaXqmxjqzDyxXRi2abtHdmpJPr+AbyBvU+GzW2/2GOHO4a+GsPaQZz0acT?=
 =?us-ascii?Q?TNu8zIUPT0Mj51O0Srhazlwa9pkL8WlV7qfK3ohXjM3AIXypq9q+t56hPw3g?=
 =?us-ascii?Q?yhG36mWQsGXeg/n4FxV0LaX2dZX35knB4kFW7lAohFwZmgIRITyivNBKnVx+?=
 =?us-ascii?Q?YdDXVMveblL1P0ceVhW++gU43dzU/AlGs0ojpmQks4wVLzE7nBSKzkODL4fm?=
 =?us-ascii?Q?8A9n6WDhx7N9P3RJ2aPqlTKxT5v6uvniJRa1DU9m+hiQoSqHf9Ig85suVT0f?=
 =?us-ascii?Q?ILNOrttlKqPKkFR9Rj/PoB3BTpdiI/aV2HO6AXyaTsL0J/tYR9iKDnp532n3?=
 =?us-ascii?Q?E9CUWwnGiSJ0wAK3eG6yZ6qMJjNUfqlcsvuYahgf4bTpJaDqxKlagj5xNO+4?=
 =?us-ascii?Q?6GNL2IQNTE8r1zleX/q1FQ2yjm3TnOuyCSqPjoYbncekRfkIHUyS1Dx3xJjd?=
 =?us-ascii?Q?A4kB8EmU1efbPO4aL9JQadjYfNRYTbgI+yuyHR3m6Yh1G9QvwNh0dJM3m+lO?=
 =?us-ascii?Q?nsBVG95ZTAHG3m0QLETN1dA+D7PrhcY8aT9nIiGkscmU2+var8+Wj6n/99Qp?=
 =?us-ascii?Q?S/5IAUkuJA1bzjXdF4+2Vz/eSf6BymIxP4WoMNExrFsF2HnyxInCEMYBJ4Qf?=
 =?us-ascii?Q?6qvHD1k/uNZSqRPHKliM7LmxqMlr6Q/vpeEFm30SunOJreUFYnwVw2od6wDF?=
 =?us-ascii?Q?HVfCPepEm5pU7JUEbpOVIeByw4Kn5VmFCCfJcZdJZHg+6lnk+Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aBcQCjah96UF17QmE7W1MoPv9cq2EajVs2DYOKNzuNt7+TQQsCL2bj8gWHDu?=
 =?us-ascii?Q?1nyotM01l17J4PbalqpPFcyuc2HKUsX0Dva7yLYSzLkrjfr4Y1H6de4BD7yu?=
 =?us-ascii?Q?Y1yQXWO5kqZ2SD9VAzjxtfPRFb4wjz2jezrs/8nTBHJjpPjAgohl0YDCt/8Z?=
 =?us-ascii?Q?k29c31QvQwQ12JNiWqZW4p31+o+eEIVx1M1wdZCsXVnvWv3JzvmRmaotnn/o?=
 =?us-ascii?Q?e6jk49x5h25A1w34iDUoqkc59NLXdCzrK3nPk/Pu0Q3Z+EE3BNd9UQX4VbO5?=
 =?us-ascii?Q?RjFzavkyqU9wA1tHCtHLa3NtcGKR5cwlb6xlAdEFUtb8ll2BJNpJlKe2YS3T?=
 =?us-ascii?Q?WEY1TZVeHhHJ7l1ilbNspwjEmpZDTADpYp5ZT6RuE7XugLSM/tsKGiIHUm9d?=
 =?us-ascii?Q?vxE9dh08LuPY0pCJRUJt/vEtWf10vlNvpZjjviVqzQNKUwdFmm+uqWFQe9UG?=
 =?us-ascii?Q?r249ARvVR6X3li1I6ortszOr+vbi86VLQudmFJTV3AOHSOMcS148lM9mHN/S?=
 =?us-ascii?Q?4Ycp1KDIqCxLyeDFu3/65xxTX1kD8O76U5fnFi1A1Ufr2mxZU5af0kZXou02?=
 =?us-ascii?Q?77ms90yggn5uaKdCS9//bDTZCk5NDoHy6N2LbrP8F4XBQcGgDDx8fLdWg3wi?=
 =?us-ascii?Q?X1TLNpwQo7SxHqkK/Y0LjPgtHFBYa2+s2tJlAN2DVastb+IWF6mgCl0AiRGj?=
 =?us-ascii?Q?rGgy0czw6ERl/02wpy31Nn9YOHVYid7Y7C3XvCj14d9Wulj7q7YRabL+Txu1?=
 =?us-ascii?Q?AOYkTJodmSAjdLBU+CJGEtkUZJwW55adiew/sQNSHC7J98GdP20F/tJIihgc?=
 =?us-ascii?Q?IuYKtlnfLlzG17vum8MHljskwnbaeoPdXwvoAMo7p6bQCScjqReSg3vcAz/u?=
 =?us-ascii?Q?nFYZKJGur0DFNp4OUj6nR2ckkhLboIYmVg/a5C3NszsUCNRKh8RHLBlHg5XP?=
 =?us-ascii?Q?67zO5U3A6sy9shu1iUFUn7MSXVwqN4Y8H/tyZopHxBBkfESgJWKFlGb6Lm6M?=
 =?us-ascii?Q?LmvywNyNlO8u7DpJwYOvySgUBBfrVskseqzFVj1dKnDTJDDFnGJKRsz1IjWY?=
 =?us-ascii?Q?1fm9HvCNRCf0nDxv32j598TlJ5hQr81A78h4cFRXZLlguSMpus0R8kikOaMA?=
 =?us-ascii?Q?uWYsaYYjMRvaZWe8I6p8HBEZM8dN4sfVVJBs4Bd5RiLd7fcolUp4mcn57GFk?=
 =?us-ascii?Q?r5XS//uUbh8s1kkzXDddXW1iEiDwpN8HG0VujoPTnWErAzpqc+zj19kFQWir?=
 =?us-ascii?Q?IUQ60nM5RrkToanxAz5pwUYNiIFRj9QQZitDSy1XOXLwLDuk7K7F/AcFBBuE?=
 =?us-ascii?Q?TJO2RTIpw14+LI9ZvJL1nodpGZJfpVVtRH/ZyLBqxnLUHrzftpivmgpUx2iJ?=
 =?us-ascii?Q?4y1EZx5/zvXOz59S663ASW2PxToS8/heogPOJqsUvs+DNIh9d/2cV9ZiODan?=
 =?us-ascii?Q?+ny6wAghHD4hanPrKgGTn/niblH2yy2M6GuKlJMVoCTFgu2G/DWghqDLrbnC?=
 =?us-ascii?Q?d5rilw/lI0G8IJlESeuUNSJKbmytJ9lpwVDGXdsdNT7RnFvtmqb4CxtYurlC?=
 =?us-ascii?Q?9I/S5oxH2yCDC0SIVW9hBve2EBb/sEK1QJGkICrQzXI08nipVJwQ1O16Xyfv?=
 =?us-ascii?Q?SrBEO0aQTgYffLDDR0uaS90=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e0a733b-c9df-412d-ed11-08dd0ceae334
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 00:48:33.1238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pMlKXs400wjv5j1KGWz/BIfOUfsMW2VG064/S84LUhDHJKRqjKIvI7SBDx+7M7Wpy+bfBzGDK+mFUg9tOtm83x/Si9IwKUOaOh256oIti96UZEzvB91Bs2DXMT+2ZO9a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6247

Historically r8a779a0 SoC specific compatible was added to rcar-dmac,
but it is same as Gen4 today, and r8a779a0 SoC DT has both SoC and Gen4
compatible. SoC specific compatible is no longer needed. Let's remove it.

	static const struct of_device_id rcar_dmac_of_ids[] = {
		...
		}, {
			.compatible = "renesas,rcar-gen4-dmac",
=>			.data = &rcar_gen4_dmac_data,
		}, {
			.compatible = "renesas,dmac-r8a779a0",
=>			.data = &rcar_gen4_dmac_data,
		},

	dmacX: dma-controller@XXXXX {
=>		compatible = "renesas,dmac-r8a779a0",
=>			     "renesas,rcar-gen4-dmac";
		...
	};

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/dma/sh/rcar-dmac.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 1094a2f821649..d50fb3f166532 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -2022,9 +2022,6 @@ static const struct of_device_id rcar_dmac_of_ids[] = {
 	}, {
 		.compatible = "renesas,rcar-gen4-dmac",
 		.data = &rcar_gen4_dmac_data,
-	}, {
-		.compatible = "renesas,dmac-r8a779a0",
-		.data = &rcar_gen4_dmac_data,
 	},
 	{ /* Sentinel */ }
 };
-- 
2.43.0


