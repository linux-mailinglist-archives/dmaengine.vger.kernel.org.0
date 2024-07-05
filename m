Return-Path: <dmaengine+bounces-2629-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC06928752
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jul 2024 12:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71FF61C2375C
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jul 2024 10:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4821482F3;
	Fri,  5 Jul 2024 10:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Am0GAojJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2189.outbound.protection.outlook.com [40.92.62.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C3D1487D4;
	Fri,  5 Jul 2024 10:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.189
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720177075; cv=fail; b=hi0GGEx6lvPTcwLjc2Q8Aj14uJZi0c6VFPEzLbJjVvBhLqt6aKcom4vtniXBSE8u0hSTUIoOp+vOTC0RLIPhBSeGNy8u7+Nuyq7Jwa35/Okut4x4crM6b/T3EbW+i+3wrvwGMzBx6P+Cfka7WOzySb9eMrYY/y+n3KVYJuKkNBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720177075; c=relaxed/simple;
	bh=wJ7hOroRqwPF0algDrHQC/tLszLH+VKQ/RQAkiFKmKY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jqJ6TA0H+36gPDnFHU51D7H4fjlH4IkCzl04BYTUD4Pn6VPO+nD3JL3iDr7NOQkSwm0wP3BSnEcds+fGlZGmmfIPBh8WlILg0XsDVc1aBl16KzlZPa5qdiCNwJsXL0y0niLWaoXfj5Ss2F3WPNTRSRc9ThU6IfHuXbW5/TC+fOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Am0GAojJ; arc=fail smtp.client-ip=40.92.62.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C0B0V67ie3vYXjwHSxOeAZoH8AK4Yf2SR5TqpNXFBiOBTekp1FiUew29N4txAUklfxfgXhmp7Y+BGxi+ml+40vlTO2UawKIRXIDdUpHSdeuR81nahTf8O1nDkHTVLo0LpQ/1sLL+k2uMQf6pXcZ2nqamHbCYqcVfZhVLxafITbUPJVGGd9ceEDWOzG22khNXOuNwqpEadzl2yOdOSwtkji7ju6+bCtqufivduFo4bS+NjCBnhBpSpajPdDmWecwz+hV5fIdzpS5qC0DcwmC6LZWGEU8ASIsPvxsWGmQQVbQbvF570GTitTds7ofyBEICsDgPzgBAmRWn8LapxZEf+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hRqVd0sFYaw6GYvp75mY7F74auCUI2hbOG6FSlVYyec=;
 b=kaIlzr6Lo5mR8GLbGPsVQSaz7ssZEm6JhvTYBFMjT19iJ6AhYQKcUtGuNJkiEALrMy5lmyQKU/e5ffkJ5NUPaJ/R0zsR0tstOneyEom1aSCQnkg7bRd7MecXiRkelgkll6Ap/RnCwQt8+xMqL14ws6L1/PpX/XAhKkmUWKO7hH/bLEI09SGWiCW6xqUnk6KZKpa2QEYShG6tUcTxcQ4DZiZ4VVHHMQvkx23acdaFju2pqSd6rz8EO0fX7KoyNlZrE/wXokQyV84RP/OpGgLNEbrGGvrzii+wFPjnBRyKpnrfJrLyfEX4jhvD+jTTkJh1VWeZ5N0So4MBSIMSiGzFQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRqVd0sFYaw6GYvp75mY7F74auCUI2hbOG6FSlVYyec=;
 b=Am0GAojJ3JSvfEpUgS08cJ/PSy/TzaTx0dBAI/iyNhPii8KjChOkCmudgbfJDALWiOuuF9vi4eTM3tO4EUE3El0PaWGSkTvbY4uWY+8IFSU9gu93hxAi3wsbFz+9Iq/AeyNoRnX3lwq5HHCX7L5jNmQ1cra2KUCC3TcmYoQK4EBpwmR97D2zW1t9S4B7a4f8Dxl+0BOM3iZlKMzuPfxSPqFWhjwtHkU9HzAFcuQN67IySaEV8rc4Pm5CI2XG9q5A6nFhmrzONsYAre3fzds18E46NS+AkBOB9E52OrCzzs2GvVzBBDrq1so+Jw3QbNXIp+qnzQaAJfH86Z/DWZhNhA==
Received: from SY4P282MB2624.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:133::8) by
 SYYP282MB0880.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:bc::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.30; Fri, 5 Jul 2024 10:57:49 +0000
Received: from SY4P282MB2624.AUSP282.PROD.OUTLOOK.COM
 ([fe80::ed78:8dd5:170a:bd04]) by SY4P282MB2624.AUSP282.PROD.OUTLOOK.COM
 ([fe80::ed78:8dd5:170a:bd04%3]) with mapi id 15.20.7741.029; Fri, 5 Jul 2024
 10:57:49 +0000
From: "zheng.dongxiong" <zheng.dongxiong@outlook.com>
To: manivannan.sadhasivam@linaro.org,
	fancer.lancer@gmail.com,
	vkoul@kernel.org
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"zheng.dongxiong" <zheng.dongxiong@outlook.com>
Subject: [PATCH RESEND 0/2] dmaengine: dw-edma: Fixed transmission issues
Date: Fri,  5 Jul 2024 18:57:33 +0800
Message-ID:
 <SY4P282MB26244599B80C36FE2B78C912F9DF2@SY4P282MB2624.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [fade5BLuAao/uCuNMCrA2Ipm3HTMgQNV]
X-ClientProxiedBy: SG2PR01CA0146.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::26) To SY4P282MB2624.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:133::8)
X-Microsoft-Original-Message-ID:
 <cover.1720176660.git.zheng.dongxiong@outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY4P282MB2624:EE_|SYYP282MB0880:EE_
X-MS-Office365-Filtering-Correlation-Id: ad2cba37-44ac-492a-abb0-08dc9ce14f81
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|19110799003|8060799006|3430499032|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	6WzhzRcBFc7rro7aA2hr7mewZqeMY2ypt5A8LwWmyfchB5vph2RqOrd7LdeF/ZkjeBh8ifPPYngvnbc7EkDDVOMnZU+HXTgtWn+CbmRpnmTgXZRL+amEQNM1bLQl1e6xt2qNdG9n3k0WFpa6zBv71xhoYh9F6hxoW/uyNvSpEvTAQN/VB80SCLreyh2EJhncxD2NEmRNE8z12wYqU+q3HtRTMd6NT9evGv0sZ/9Mf7efzpY2jNk0adTq+8MEjbe2pUVJRHRDDP60qyAgvyDw86UyH82ahjX4toDBx3DyXGvIItLMFdnqfCqfvSo2u4zTm/UFjcvEGeeZ9MwdOrPTd+yMZ6TDiqJrh5EHHUSeQnFIWnuvLlxXbBgHmGUJeHFW0iZ7yw6liLJ6z3PhXn+WBFE7aAChiFmqpo172K7bLeKQ1iB2P0jJu8rB5STC2x6tz/FyynCLvMJPd8OLs86KeOEhpMOJxuAJS8u8w4C8n/PJpWoeNk+c95SLrn1hjLBg1J2jntfKUIaSk/ucXRP6LztDmliSeFDcnK3mjj4ZsnD06mPDIgYNp4JnrFGJjbZ43OvPoKiI011Yp46iXki385ir1Dg6mG0ltzKJW/jNi4RFdoLaLHKRo9OIBU9Gf4nFSYlNqMgL9WRpdCIwgef5jv8FLHZwH8r+CkCrqUIjw1A=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kD4k2ycmNtkKAvpBDBINyi2PAlo4fKn9R0JI3TWaK7JSuTl/Mbj2hZ5TvXNx?=
 =?us-ascii?Q?vXeaT8cvZuuBaQZgbCMgu2MuaudV+qf3xiDotdCzUJ6GYM8C01M5bSzw/PaU?=
 =?us-ascii?Q?13DJXx2szMxxNBp/pQoRPyYiBNWpr1rleUkyUNHTgOC+oTZSmAXRdSaeGXnY?=
 =?us-ascii?Q?hwu9OLq+woxleQIrp7VGjsOuxiZtjCJw1NKdKSOjFRvlj3cVwy4pxCW2ouxP?=
 =?us-ascii?Q?b5IaVVLgh74JwA0roJM0hLCWrJDn794dvERkR3rC0snpkb0KMoS1xrDUOdck?=
 =?us-ascii?Q?1I9iBWL8f6O9MzYrCrKYd6TNvmhb69pN1jFprEaSzzI0kKhtgAzn52TlOz6G?=
 =?us-ascii?Q?POFYOngqVqjBAWjTCiN4BXCGafq3oMPrhltI23LKsNE9Kl81twKED5blFhuX?=
 =?us-ascii?Q?655hmKQcw+axc8A/hXNvjHUOl2hklJlNmE9qzDb+Je9x8UziTK/o6t0osq+C?=
 =?us-ascii?Q?wWJ6FMBsOOmivz0GnLinPCvqZ67BocnGgNoUZ7dL6GxQjnzQsxOKE8PAL+Sw?=
 =?us-ascii?Q?P5YuXggDS/rmx+7gC3eN4Ygm0Qb/2iq33ceO61KV1uLECpktEBNRnHXsXo14?=
 =?us-ascii?Q?aO3VRIyd/bx0ZA4F4k2K8B7K+E9BnjH1e+oMl5iaOR/cn0jqSd59oFLH1Rr/?=
 =?us-ascii?Q?i76ceXvPPFqmSwwrk9RHxrjxk9er1c4W4cJI3gIKDWj+FtNfKtRAZ+1J4xCL?=
 =?us-ascii?Q?KbRsE7KzfGrsmaRLZtb9n55J9+xaJg+hrNQ8xnqUDlisuI6HwVYodwCKKLQ9?=
 =?us-ascii?Q?7/dDDOIk8TRg2FpNOUJA7EooqOI+DKarXgFfUAXFe8YcNxVvDsc8nNimzDKA?=
 =?us-ascii?Q?4LDA+Ivi7NPsf0nxTo4Hy9WrSkAvliU58ZkUMfiDAo3ttA/YkioZIdS/RKDp?=
 =?us-ascii?Q?pe6n4p/R+QYAR3fgXeunn7yTs/0Q8aXSnwUpAsv2iYx3MI8fHgxlsd8Tf6Ji?=
 =?us-ascii?Q?Eudhv7f2NdUuDSlhmPFNciRG9oVU16Rl8dJu/Zpm5DyY6V/URlGpGJYA3D6q?=
 =?us-ascii?Q?L68oTCNerEN924gcQ6FjvErTnpcPQ4ChZ3yTiH4Wxx3XmKEG2SrHrl/so6mz?=
 =?us-ascii?Q?hsLSv35tf+URShL5xK0/0/NO5g84EZjJP5qtpRSIWKQsV1mBBt72++Pk235h?=
 =?us-ascii?Q?HTxcyQ4O77qsPH4KUFWV/D1VsFwDvTJhNjQ4vq+eUTBIrvOoTTpkKdfMcFVE?=
 =?us-ascii?Q?LdSMGbVLX5njHo96zcmopQQZkqIxWQY2yzO8nQqo7uf0oh78mikF8u+A+VIq?=
 =?us-ascii?Q?DLqofEJl9XZq1A8paMv7?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad2cba37-44ac-492a-abb0-08dc9ce14f81
X-MS-Exchange-CrossTenant-AuthSource: SY4P282MB2624.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 10:57:49.7530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYYP282MB0880

zheng.dongxiong (2):
  dmaengine: dw-edma: Move "Set consumer cycle" into first condition in
    dw_hdma_v0_core_start()
  damengine: dw-edma: Add msi wartermark configuration

 drivers/dma/dw-edma/dw-hdma-v0-core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--
2.34.1


