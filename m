Return-Path: <dmaengine+bounces-2102-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3158CA07F
	for <lists+dmaengine@lfdr.de>; Mon, 20 May 2024 18:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F64A1C20C50
	for <lists+dmaengine@lfdr.de>; Mon, 20 May 2024 16:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADDC138482;
	Mon, 20 May 2024 16:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="I9MGjIwc"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2051.outbound.protection.outlook.com [40.107.14.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C3E137C41;
	Mon, 20 May 2024 16:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716221413; cv=fail; b=H+Ey9KqPayoJeyxKA0//kh1HIFZdgvbBpGz1h0J99uR6nLPezxCwBl8nxfrFomj3rXNLUkFk3XZwie5VW+S47x7RHqNEJMKD3CyrvthWKvgEl3HMUdqNBNubh8ZA4xJs6PPbhc2faASbCkbBJZUkAy7XkMjEYuiraRcTisxrKxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716221413; c=relaxed/simple;
	bh=wt57gsZfa3s3Z6Q569TN9f6t8idnkZsgh/XKjwvXUOc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=dSoXNctt7xIjQRiv0YbuPU1bFlVe60CO99g/wY0IqDeBRGsGbRV21ewxm5hpTj1V6dtANm9D9hxB80Xv2OjHry1RxyBSHofMEXeHZyafzb5anNnnSuAoe7XyJ3560cUj8mqgPFJ/kH3BLysqdh7h+SUJcmY7Xl9Vbde+kQqGerY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=I9MGjIwc; arc=fail smtp.client-ip=40.107.14.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cl0T8agZ6mdXpID/YIGWADeXrCqK4nmOvaOmNuCAJV+hsH+l1DniDlgbMbymHLK18yaKE5F6bumGXmr9FP9KbyxVZgCq27HzXchCxeogjo2eZ7EAshoCI2oTx9teXqs1drA0zPffTTQplOV7BddL76o0C01CT7NVQ3LHOHothM4lWxHe6gFoMXDjoUZQpnJxX5wo11fMIRrriyBhCP05AaRXbJxWUab+ZO+J/bj6/XtjLPPQzzv3pmNVPQ4P4pntlhSiM3Jq0trJO7xT4b3cYJntLUcpaNdq+C+SLYzgtWkBgu4H/Cy0p4vLXHcFULs6xgajIfZZbQjDyiH0jn63qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLYmqQJGX2KIl9hOQmg5dXxOXeYjkDMz3QvktiBUt2w=;
 b=HZa8OdH+DQD1LnK15U2IqchPWhuZWsjqQmq/ZPRjKDSsRGMmA6KiVZVmqCJLQ0P9fTtVodob0l+xaObRMamez28GXrjt23Q7882q+xTZ+WAFAFjS6FRR5xCUQ0owX/NCVTH20ZPEoH9RWvTRoJabeuF5OU4Wqexi/QSg9I0Aa2nu8XiiEbKXbvuYj6dpWvyLByQ2QuPKJSQZ72AlBEke26MRj/pWK8vBbxZGYjzRi5FV7Edt3Fp4Ap6ny49dDWX21Tc/UEeUHTnjINyWbd4tfdGXq1eVGFKg7qfS97k0ghABXSkdiUTTJvhASZhp7G+gRogyEJ88Y6qzmJtMai5qRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLYmqQJGX2KIl9hOQmg5dXxOXeYjkDMz3QvktiBUt2w=;
 b=I9MGjIwct2P40N2w7D3I1ydMwd5Q6w9bpbkVe6gqnKOJo2zF/r6jbeStsT6JKp+SPrT3xBIrpDhdRz0mC9X00Yct/pY6UCPbsyFdBx0M90PQNzEkUCjq3YxAqzoP0B4cbpdvppsK+C99w7gqd4iutA2KZNa2EaJjDTZwUuOCAkw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8535.eurprd04.prod.outlook.com (2603:10a6:10:2d6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Mon, 20 May
 2024 16:10:09 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 16:10:09 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 20 May 2024 12:09:14 -0400
Subject: [PATCH v2 3/6] mtd: rawnand: gpmi: add 'support_edo_timing' in
 gpmi_devdata
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240520-gpmi_nand-v2-3-e3017e4c9da5@nxp.com>
References: <20240520-gpmi_nand-v2-0-e3017e4c9da5@nxp.com>
In-Reply-To: <20240520-gpmi_nand-v2-0-e3017e4c9da5@nxp.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Han Xu <han.xu@nxp.com>, 
 Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>
Cc: linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716221390; l=2587;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=wt57gsZfa3s3Z6Q569TN9f6t8idnkZsgh/XKjwvXUOc=;
 b=QaO43pC66xRkKK1LdzO7pbm2N8V/6TKHLuFFu3WSfXyQjCaJ3stMRIn9Ep0O7p97qkGaH29ph
 2L+gBRNIrquCnh4T7mLr/WGVL/AIbkKy5o29qb99Ba/zO8+WUwPf4w8
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:a03:217::32) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8535:EE_
X-MS-Office365-Filtering-Correlation-Id: ba2a5af9-2db6-42a9-6a38-08dc78e7521a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|7416005|1800799015|376005|52116005|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MTM4WE9ZamwwVVRRbVBMalpROEo2VjBHd1dndjIvYURwZjc0OEl1VHhpakhs?=
 =?utf-8?B?aE1iNjJOZjhzR3BPS0dpRUNSamlCQldvSnd2aE9ERk9VK0xHK2d4SXA3cE5Y?=
 =?utf-8?B?d09menlUamZGNFRQMEM0MW9jSEVlVE5iTXd0K3VSOHFQM1N5NXBxWkJ5K3hw?=
 =?utf-8?B?OUsvY2pCeXcycjU2cElzOUdnNXc4bmtuUkMvR0dzUWFBKzBMZHVqc29QTTdZ?=
 =?utf-8?B?VysxN1JtSHdLTjUrTXowOXFSbm9KU2RCckx6RGhoYlc3bzVBNkdQR3JzTXI0?=
 =?utf-8?B?TmdEdWpXT2F3SXVIemJibG9LUTV2Um9nd01hY1NyME1lZEp1aGcwUGc4VFU0?=
 =?utf-8?B?R283cUdBL1k1eE01T0VvdlV2bnFycGExY1hPMTNjMFBMRzkyOEQ4ODR2K3Bi?=
 =?utf-8?B?R3ZzNVlTRFNtaEo1a2pCLzF0VHRhd1ExR1NJNlBZdUgzU1lyeUk1bzhhZVlE?=
 =?utf-8?B?dm1tdFl2aU5iSDNKVWt2b01UR1R5a1JZamRSZEdic0FXL0ZRd1NaY2pzSzIv?=
 =?utf-8?B?TVh0YXRBRFplMEJmbTdUTVdaVEw0eDBIUm8vMHQrUDQzeUs2azNDWGNlOWpk?=
 =?utf-8?B?VEdEMlkxNFk1ZDh3bjJQZndhYjRVa1h4b3plR3NRMkQxVU9WcHkzT1R0cUF0?=
 =?utf-8?B?dzU4aFhERHJUZDZLd0FhV25wdEpuNFZibzNlQnBxZlovOW93dUV6WDdja0Nw?=
 =?utf-8?B?Q2hHeS95VDRxc0xyQWhTQy9WOHNOYnVGbTl2UGFzVzdTd0s3eDhrQklhZDZ0?=
 =?utf-8?B?emRudnBDS2RSdmcvN2w0eUplajV1RlRJR1ZUYmZaTlg0bXQ0M2I5Zys3Mzdp?=
 =?utf-8?B?bWVJNjNvV3RyYUgxNEJhN29iOXdjLytpbHEwWmw2SjV0dTgveHh0bi9tWi8z?=
 =?utf-8?B?dkJsZDI3TXJtYS9jcVdqU0Z0Mmt1Nm1rYUJhZmVteWlxcGk2eGdBa3lUZXAx?=
 =?utf-8?B?QzVvYVoyZWNncE9Bay9kZk9HK09SV2FXZDhVc1VIREY4eHJGZTBabFZZYkhI?=
 =?utf-8?B?TlBNUFhsY2hYdFMwMzRrNUJQS0N1eHVScmVWK2RZclVnL2tBTXJuWG1oc1Jp?=
 =?utf-8?B?cm16TTdYM1dobVlTcW5aUEhRSlk3elc5UUEwRGRSeDA1OEdJUDBTOVBwMU1q?=
 =?utf-8?B?Y0E4ZE9QZk53VXZFU2FWb0FHM1VuekJEcDdCcElad2EwTUVLbmJ5dVVnVW90?=
 =?utf-8?B?MjNUMkZGS29tNmV1NW9CQzB3T2tUbzhUTFliVmNiSTlNdW9jSFRzQ2R0WXhm?=
 =?utf-8?B?MEVXWDZlUDE5R2hyUzZ0MXcwRDhvWGJQNjZVRW5yVUpReFJIM0R0NFdnWGwv?=
 =?utf-8?B?Ymx0NzltWG1zSnZjVkVRMzMyZ2NpQjdUME50Q0JtT3BUcmxXMWxybG8zMDRL?=
 =?utf-8?B?bFBmYVlRUFV4RzFMb1ZhMXVnSWxRUXkrRk02cUFwZnZ0eWF5cE5DclZFVDZs?=
 =?utf-8?B?dkpISlpOVXRFZHVDSjEwdjRNWDVXWFhpUmpvMEdjN0NzcWtqMnF4VGdmTzRz?=
 =?utf-8?B?NzFJUWQ3S3hkc0lHbUhmUXI3V3ZYQVFtNkNadHZYTkgvMmRzeXBCM0pERCtv?=
 =?utf-8?B?V1hzaXlxUE1GTWJQQ2VZMDhyRGpwL2FxLzN4TktOeFVuU1V2WjhvZGhpWGRs?=
 =?utf-8?B?ODl0bzV3Ny9DNEMrSHgzakFsekRMQ09Ma2VqYzNnWWo1K3lwUVVuRlpGVVFE?=
 =?utf-8?B?bFI0SElBdkt2MUJnSFRsRjVkSWhvYjNvcHNkWVBQSGxicVFnRFZhRVJEcFA5?=
 =?utf-8?B?Mi9TOTN1bVh5L0o1UUwvRU4reXR5R2hNWTBSV1lvVDV4TUxBUmhibXhGcGcw?=
 =?utf-8?Q?4TaoiYzSg0N5+Don7qUqh4S+licYbYg0Cuk+w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005)(52116005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TnEzMzhleDJuSnl0cGdHRHVkSnpUclBnOHZuaXg3ekZubkcyeksrOFMyODVJ?=
 =?utf-8?B?SWMrcFhNTWNjazBVQXBDaHJ2Nm5tZVBQMi9Cbzh3b092Q0I3WmNTeUpGN0hk?=
 =?utf-8?B?T0RxOUZOREJGL1RWeDNiVDEzYVpLQldqcHhSYXVCMWIrUkdRVlRRbVFRTzB1?=
 =?utf-8?B?cWpDOFo3R2pxWTZORkNUYnZhaWlaZUJsQ0c3SHVCNjI2VGY2SGI5Zk5xWHM4?=
 =?utf-8?B?TXpZdVZpSS9Ddytsd3UyTWRMQ1Z3ckVTc2FveFlEbCtNRmhmQlpOcS9yN3Zh?=
 =?utf-8?B?dUtBdU8wRU9ObzAxZVFkNThsWlJlUW5GanZzZ3J5ZXZTV3FBWE4rbEFacklN?=
 =?utf-8?B?NnUxOUd2dS82NGx5a0JnaWcrUmU0cHdRYXU2cUlFNWdOdlZpY3UxNm16OTZt?=
 =?utf-8?B?UFY1aVgyblJwQk4wRVhCWVdHTjdoelFwT3duWU1VeUN3MGg0WCs3OHJTYVJB?=
 =?utf-8?B?OFZhRDlzT2RFR05LYjQ1SGJRVXRJa2Z3REFaTDRHeUl0U3N1ZUFVK2dZSWY5?=
 =?utf-8?B?NGlpcGdUVjJoYzhwbnM5R296T0FucmpiUk93TmtIUG9Oc0dEOUFUMHlBY2FC?=
 =?utf-8?B?dVdtbzJyNGJrT0FhdlQ0ZHd4ZWdDTkdVakc3YWcvNWtEZ0pSYUttOWhDczRR?=
 =?utf-8?B?MEdHNzQ5UHY3VVBXVHFqRDF6MkVQd1k1emd5VjVwWjcvY0NQaU5qS0R1Wk4z?=
 =?utf-8?B?TzI2T3RGaStsL09ONXRIOFBQa00vSGkvRFc3VllEZmswSWVlNFFhUWNnTjVv?=
 =?utf-8?B?UW1rQnVMNmsxUWRzdDRRNmc5cTl0OGhmeGJFNkF4dk1PQTc0SVRoUkJOOUY0?=
 =?utf-8?B?U3c2cmpzUHIzRXZ4RW9yTVd4dUE2Y1BMcENQZ1BEbWdjamxlTzhqRFF2OXhz?=
 =?utf-8?B?RGdpT2lvR05SR1MwVVFmN3ZrelVmc2Zua3YxRzJBN1dZR1JDWk01cmNTcEp1?=
 =?utf-8?B?UFhUR1FNUWNzYWhwYTFZTGtXc21ZTFYrbWR0TVlpUVVtZHlBT0tFd2M4OUxJ?=
 =?utf-8?B?RDlqSXoxS0wxZHgweVhWYkRPVG5uSGprZ3hJTFlQeGZIM1dtL2FVTkE0UDRj?=
 =?utf-8?B?YVdOOFgwNzU5L0V4WFhaUkJnTE15ZDV5TnAyNGNYZXFrNGxaTGZlZEFVbE5x?=
 =?utf-8?B?ZDlWL1VuWWRFSU5NMzlCQUk5MHFzTmIyWUs3VUg2aUV0Q002ck9QU0lCQXU2?=
 =?utf-8?B?cWsrdEUyYUFkcCszUzlheDVvODN2blZjR3B6VElCdWs2UXVMcjE1bERoSkhx?=
 =?utf-8?B?U0ZjOEI2dFBqL09RZm83SXZUYUI3cWFKcjVDSzc5VmhScWdxNjZWcjBSdWo4?=
 =?utf-8?B?aHZTOUhwREI1V0hKY1dNSm1ZV0ZQbStjS29oY09qQk42aVhmd095T0NjNm55?=
 =?utf-8?B?TXdGQWVvZWZ3UUdEaEZrSXJJS3JNUUlPdVZTSGcyNmpQa005bllQNkFvZ0kz?=
 =?utf-8?B?a0Q4cE5IL1plQWpYZVI0TWtmTlBDRU1GR3liRmlJbnpHbzk5cDVQWGNHZ2h4?=
 =?utf-8?B?Y01BbXk5SmNKaFQxKytiV1hURHlhU1BJbDNTWEIydWZBM2FiZ3ROSGtYdmd6?=
 =?utf-8?B?VUc5VHEyQVhLYXRvTS9aWFVPVjg1TklPdnFNdUN0aFlPMlMyU2kzaGNrMFIz?=
 =?utf-8?B?S1VUZXNRK0MxZk84eVBHdms3STZuajRuYzNJVGE4MVp2ZUU0S1RxeHlJZFlr?=
 =?utf-8?B?MXhQM2JSR2RDS2dJT0RZLy9HRUFCSHJGK3NNRTA0YVFOQ1RLYlI2L2Y3MnFV?=
 =?utf-8?B?bm5kZEVCTXB1RThOTUVTZmt5bXQvcHJEdVIrNi9wWlBRTkRwU3N4ZUtZMHN4?=
 =?utf-8?B?MWZWekxSMnV6WC9laXJDUlBBQVZTaDc5VkpBNzh6Y0VCb0Ezc3ZsS0IzRTNh?=
 =?utf-8?B?YlhhUFhVS3phTW5TdjJqZG14eEJCV1I2QU9jUkVzVTF2L1pzekJMbjBBRCs5?=
 =?utf-8?B?Q1ZTajJDajgwanFMT0ZQZ2xaS0QrcndoOWV0cVBaRm54V0N4Szh4dDlNZVFl?=
 =?utf-8?B?dzREZ3c4RTNWUGh4Q2JQcTAwbkMycUhUTWdadlZyb2x5QUJCekFjbENpSkxs?=
 =?utf-8?B?bytSTXNkRkhwazk2SjZTTU8yVURnclBxTU5BcmNHbEUwRVRyMjkwZjFhTkZ2?=
 =?utf-8?Q?vZMo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba2a5af9-2db6-42a9-6a38-08dc78e7521a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 16:10:09.1093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OtpD7E8dHTEyXzZ81J5T27QPFyf/dJhqpXSaxp+2hjN60zd/2tcKMwOXnFbKmxvyciFPhPRak9y50X5A5ZPd9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8535

Introduce a boolean flag, 'support_edo_timing', within gpmi_devdata to
simplify the logic check in gpmi_setup_interface(). This is made in
preparation for adding support for imx8qxp gpmi.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c | 6 +++++-
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.h | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
index e71ad2fcec232..fbb1f243ef129 100644
--- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
@@ -983,7 +983,7 @@ static int gpmi_setup_interface(struct nand_chip *chip, int chipnr,
 		return PTR_ERR(sdr);
 
 	/* Only MX28/MX6 GPMI controller can reach EDO timings */
-	if (sdr->tRC_min <= 25000 && !GPMI_IS_MX28(this) && !GPMI_IS_MX6(this))
+	if (sdr->tRC_min <= 25000 && !this->devdata->support_edo_timing)
 		return -ENOTSUPP;
 
 	/* Stop here if this call was just a check */
@@ -1142,6 +1142,7 @@ static const struct gpmi_devdata gpmi_devdata_imx28 = {
 	.type = IS_MX28,
 	.bch_max_ecc_strength = 20,
 	.max_chain_delay = 16000,
+	.support_edo_timing = true,
 	.clks = gpmi_clks_for_mx2x,
 	.clks_count = ARRAY_SIZE(gpmi_clks_for_mx2x),
 };
@@ -1154,6 +1155,7 @@ static const struct gpmi_devdata gpmi_devdata_imx6q = {
 	.type = IS_MX6Q,
 	.bch_max_ecc_strength = 40,
 	.max_chain_delay = 12000,
+	.support_edo_timing = true,
 	.clks = gpmi_clks_for_mx6,
 	.clks_count = ARRAY_SIZE(gpmi_clks_for_mx6),
 };
@@ -1162,6 +1164,7 @@ static const struct gpmi_devdata gpmi_devdata_imx6sx = {
 	.type = IS_MX6SX,
 	.bch_max_ecc_strength = 62,
 	.max_chain_delay = 12000,
+	.support_edo_timing = true,
 	.clks = gpmi_clks_for_mx6,
 	.clks_count = ARRAY_SIZE(gpmi_clks_for_mx6),
 };
@@ -1174,6 +1177,7 @@ static const struct gpmi_devdata gpmi_devdata_imx7d = {
 	.type = IS_MX7D,
 	.bch_max_ecc_strength = 62,
 	.max_chain_delay = 12000,
+	.support_edo_timing = true,
 	.clks = gpmi_clks_for_mx7d,
 	.clks_count = ARRAY_SIZE(gpmi_clks_for_mx7d),
 };
diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.h b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.h
index c3ff56ac62a7e..c8a662a497b60 100644
--- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.h
+++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.h
@@ -86,6 +86,7 @@ struct gpmi_devdata {
 	int max_chain_delay; /* See the SDR EDO mode */
 	const char * const *clks;
 	const int clks_count;
+	bool support_edo_timing;
 };
 
 /**

-- 
2.34.1


