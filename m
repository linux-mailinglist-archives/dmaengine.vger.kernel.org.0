Return-Path: <dmaengine+bounces-1208-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FFD86D5C9
	for <lists+dmaengine@lfdr.de>; Thu, 29 Feb 2024 22:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAEDD1C2389B
	for <lists+dmaengine@lfdr.de>; Thu, 29 Feb 2024 21:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DD1156D33;
	Thu, 29 Feb 2024 20:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WLBFUyPO"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2040.outbound.protection.outlook.com [40.107.7.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBF9156D1C;
	Thu, 29 Feb 2024 20:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709240347; cv=fail; b=LGuUqqPKZgdQtGR7mjtd3lmgftIvUaH+nrkC3HdVLqh7K1YvfOiAMVcpzXBYps3UFFHdfohqRmLiVML/HJQtu0AFmlf6pzYF7AWRv/dxrgmhKinrtXsbktyNoo1dJF/R3WI/vjSWb79KM3LdAKVqtjOXpIfiolKvMtJL+GTlhlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709240347; c=relaxed/simple;
	bh=1SY1nKChJ4s31bmrpysVWazodvllDv9ahLCc/bCrYcQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=qeqBG5ip7D/b7l0oK5DOlQZOK9bGxwp87pMOC7a27rH/EcZtMwvcNO3KR9CrGFto5vmhCdHfvYJkAu555cE0kE7/Bdgw/7DdNtD7rAxolN21i4MObeeEBIO6k5BcA+L/ErMpxpSQcb3vVl6izLpuAX8TmoYek7/9A6XYLwZ3dTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=WLBFUyPO; arc=fail smtp.client-ip=40.107.7.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yw+5d2DGWakKLDdQqZz4cCdkbyA7fFSewSpKln1DCLpVe84zE0QyaegMctdNCyUeVEH2oBkTLxqcg01Ao+gzx5tXVpRN40sfv8lTNdOgilrLS16SUwDt0G1S158K4m0fT9xmqqB+nHB4aNKPfil+9CEVQRM5RU0kl7CD+pdHA1CiKboe1og0Ee1cRTCkR9b402bTSRusgWziXySrKkvFVzZBRi4q3ePR7Cv/wn2JxLxqAxtPVDd+scnOrP7mY2rHY2f/xXd3ocsE+zz8Ou+mfVwd6KKiDgprh5fHN3puX3J6orlyvFvqgYMLmc1j5Tn5a4tk8h7nMTL8JxgE/75pww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O3UHH8qhH5HTx8E0tLZorZnJnKCrjOdx/qvKkcds5Vg=;
 b=dhaOSeEEmkl54ymXL0vRj8X6bz1y2TJYHPLcMyWRBNaZYgRxAxQwIG88OaXuclqsI1LMxARggrjZuPnSJUcyxwETAATvNVZ+VXmno873WPltMBaxTcqaVr6BcyO4S2gjUI4rJ+mxfvOmzSQheBcIO2T+sRA1StWX4YM7WCuOCFtJuf4vXIyz6/DNiclaXvoFkidxvPvDJslTq5OPuiq5J9nDSVOyODGjPzpI2chNxjnjz5Ec7Pdci3CvGKxSztmJtp4wxx7yDcNqZSqScpYZJWMZOwHOfRutQRphTvDtOthZKD2F7vfkwSYUofnh6f33FL55zh7DqNbGee49v82gdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3UHH8qhH5HTx8E0tLZorZnJnKCrjOdx/qvKkcds5Vg=;
 b=WLBFUyPOHz4cbwEHHepUNJPeTCgAUuOrV6J4qV1ciN/Am5WhOAyQ8IptqIanuqG9IEMfCyHC9LWsx2vVg+be6lCujN7WdJGQV0+O+eXytL0c8OVQ6/2ytXqTQJQ+iFx1QyU8/4IBjpCuLHPx2VsttrdT0Isgxwccl6zGrXubJ3c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8750.eurprd04.prod.outlook.com (2603:10a6:102:20c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.40; Thu, 29 Feb
 2024 20:59:04 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Thu, 29 Feb 2024
 20:59:04 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 29 Feb 2024 15:58:09 -0500
Subject: [PATCH v2 3/5] dmaengine: fsl-edma: clean up chclk and
 FSL_EDMA_DRV_HAS_CHCLK
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240229-8ulp_edma-v2-3-9d12f883c8f7@nxp.com>
References: <20240229-8ulp_edma-v2-0-9d12f883c8f7@nxp.com>
In-Reply-To: <20240229-8ulp_edma-v2-0-9d12f883c8f7@nxp.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Peng Fan <peng.fan@nxp.com>
Cc: imx@lists.linux.dev, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709240333; l=1717;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=1SY1nKChJ4s31bmrpysVWazodvllDv9ahLCc/bCrYcQ=;
 b=alYNgGTGK0QB6E6MYKU4CfuD0IqzfjPRVuoklU6NM1a74ucEKKpaFIM06+fJFHh15aeqwBSEF
 2wquYUqdIrmClEWom6pALzs6gXGaOStpyKNXYO88KfejXlcT+010CI2
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0060.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8750:EE_
X-MS-Office365-Filtering-Correlation-Id: a7ceb5bf-5970-4a37-02e1-08dc39694341
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DByijwzShQjc+TEt+3FU5Ha5IpmTMAAmJ86rsNBvHpXmSXS+HDCSFQwvTr6BS1XsRNc/kk+z/JIGXKKT+Hy9j3Nb9/k8OyBSzg9sAf38X8vxr9aqlQ3GCxEig/hOgRBURKYo4mcPVv/n3fhd4ZxTJ3SPew4GSlXbnyZT6l0IT5HviV5ORPwLQQtV+KdgrGZeyeU7dE1EmhgpyCsvj6ARAlOhODea7wCka8wDvnulS8BA85RBM0WozABgViIYWCiR+z/lsIfHL3QUiTc40aRR0em8NCXIW/lXbKqSnZKVSF4jmSZER36vdQjHfv6Tj2GBXm6Gobxgb32hlchhdr8h++fI3cjvN0Prq511uqxmjxLPOaskys8dBfqWAdh9PDgcHy0mfVL7D8jO8vx7lRE5vOgASKGPoUJu6vI6mTLK4CGj4Y+UKO3I/iOVNbGS8lrTxsIu8sN8FzAgsINJE5eeyuy0hxKhYGwDcjYb1icBC9jC108frg/XmBTSo8gU5h+3zMvSlYHRU5Ka/1GOjRdubgJFumV/KjD+VbQ6yU4omMRJOdMHr82sW/mRMqHP1kOHnOFvO+IQnFOMeUg7d/kP+byY66PcWtTeHudvzOl6SIXIBECSfaSDIqjWa0/6OxY2XC6Ct1Ch7Po54XRX06hpR1uzKRbCRn0mICacpyjUoahQxSypuQK0BZkuzexTr9Jd6aUaBVwOOa8FgX86dEO+0WE9Vz+sJAGTjhyXt37dF7Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2FCTHRVV0I4V1BIUkUzZXI4WUpUZ2pVOUtyb21Pc0Q0eUxMendXQ0dXTE5C?=
 =?utf-8?B?MVA1bU9aK3BMTG05QjJ0WDZHbGJJYVNIZkhzc3pMUmprbnBRdFlzU3VsYXdp?=
 =?utf-8?B?bGtxUnJycXFQY0RkUm9vTzN1S3RSa2YyRVJ4Y0FFTDdxTU1WWUUzamdMU1p5?=
 =?utf-8?B?MjlqMk9WZ0N6VVYrOGJvYlY5UExuaXI0WXVvMEl0Wnh5cy9RZFZmRnEvNTF5?=
 =?utf-8?B?NnY2aGJZQXpjbFV6K0ptZExmVEVmOHd6N25ReDkraUdESkkyNjE5SzJoSFNi?=
 =?utf-8?B?ME43Wncrc3RxUVl5Tm1TVDh5Q3VwckVSSWoxRTdyZnVhVm5PTzNWTUJmTVVl?=
 =?utf-8?B?Z0ZKYjR3Z1dxY0owRmVwU2taRzBBNkNpK2R4OVRkL3V4eCtJVXBiQ1MxclhG?=
 =?utf-8?B?bEJyelVrL3cvZ2NteWppZEJXMjY1V29iQ255YUxQYkNJMW90RjhqZXlacTRi?=
 =?utf-8?B?ZjBvWUpQbUJjMHhqV2M5aElEay9pVEg5VWZONjRRakxMRWJUc09Jcy9CTVJ6?=
 =?utf-8?B?T2NWcjJiU3JzUVR5KzlpN0Q2TGYzT1pUbUcyeXVXQkowVzBUTjMyVzZQTGhz?=
 =?utf-8?B?Q1hHcGRrRDh1dEc1c0VLUSt1M1d5MzloQlZaNXBlMXBBdFJNQi9qcFIwaTFR?=
 =?utf-8?B?SEFoNHhlR21oVitDZ1BRQnhYUnY3RVFTUThDck1YTzZNRGFCRmxGc0dwVm96?=
 =?utf-8?B?Q0hEQlFHdGMvem16MlY5VXhaN2xTWGRBS0VsVjdmT016TmFVMitaQ2xIMHhw?=
 =?utf-8?B?Qm5VSlo2WWZZZDhSSGREWis4YnR0YXZaaTJpRWV4N2EvamFzUFBQSGJ5eUFy?=
 =?utf-8?B?aVlCWmZUUUF3VXgwaTBSMHhpY2VnS2MyU2F0Qzh2eHdDbC9TaGE2UlVwbzE5?=
 =?utf-8?B?SVg2UmdTQUVmbnZSZFErL2lDcTV0MVpHTk91dGJHeVpHT3VCOG9aWXgrNS9V?=
 =?utf-8?B?czlIRlh4MElodHdHMVg5dit6U2dqcGYyUkxJQjQ4WVV1eUJ0a3pJaUI2VDlC?=
 =?utf-8?B?WXRDaHQyQ2RTSU45WXV6N1pIb2J4c3pwY0NVSnVyVjBIQ0hucm5kcCtVK3U1?=
 =?utf-8?B?OFpBM2xpMUVyUU5PTjY1UXFnS0xDanhmVDVSckpCYW9Yem1QMzA2c0xFa3Ay?=
 =?utf-8?B?OFpGZVNXQVlRblRtY2F2eFR4T0lTRkpRSlh2UHRlNlBNNkh5bmdCZHlaUTAy?=
 =?utf-8?B?dks1VFFrMi9MWXFVREVFaTRtZTNiV3RlTUxkYjVoWTI2NUU0aTdwWmJrZkVN?=
 =?utf-8?B?RTUvU20wR01UcHRpZ2xtbHk0NTQ1Z1pTa0ZyVXY0c3lhcWJ2MTZYY2t2Vk9s?=
 =?utf-8?B?YXZCaVBKUEMwQW1oU0M1SlZCWTBsTW5nK3h2VXZSZDhzSTFWb1hrcnlSNi9R?=
 =?utf-8?B?MVBDTTdmaklKTzB5SU9CNUIwY1o1SVJoY3d0K3NYUktHNzJvT2dxc3RQNDZO?=
 =?utf-8?B?d3ErZnFYNVZLK0Y3a29USmE4OGxGUHBQQWFaVjhDSyswRWx2b1NlR0dKaE9w?=
 =?utf-8?B?N1EyRXBNRmxhNHgwV1NUbVBQVHg3WUQwbDYzSmFXVy9RZGptOW51YjNBUGVD?=
 =?utf-8?B?K012OTRTcC9UQmk4RU9YN3JDa1JTL01jZDBUR3hvWlNJSTZjdHdvZW96RWlT?=
 =?utf-8?B?YVhwTk0zd2lzbzdheGRaQlpoY2VaL1dDdXJaS1pwNVQwaXl2czVXNFUyUVlx?=
 =?utf-8?B?ZWZtYjRlc0RvMzBLYW9CVlgrQU96cGR5RWV0ZlRYTHFpSTEzaW5QV3VWSXZl?=
 =?utf-8?B?T0xma05EOXVYQnlVTFJ1QU9RM2thRlpZd2dLVDNZejMrZHZ2TW1aSmxYYU9p?=
 =?utf-8?B?MHRTWTJqNVBBTDB5cHJJNnVpUDV1ZGY0dHJKV0s1c1hlb2FoSGVNSzlaNjNU?=
 =?utf-8?B?RUphcHNHUDNVWjh2MEIrRWhWdkRuMlpnUGtta1BLdjhRZHIwV3FxbEU0RDU4?=
 =?utf-8?B?dWs2emM5VHcvQXk5SFNuWnZUVk93MmtiYTJlYWtES2lCanBzRTE2cEFrNGR0?=
 =?utf-8?B?emttYUFhSXB1Snp4Y3lFTHNlMFdIbXRVTUFVVXVLWXZ1Q2pwUW5STEhUVjBQ?=
 =?utf-8?B?WkFVR2NDbmk0eVMrcHp6SW1xQnJXeU8raC9JdU1xeU9XUEVGZmtNMGx4enh3?=
 =?utf-8?Q?jSTwQL+UtOryfEBnIhV9g023T?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ceb5bf-5970-4a37-02e1-08dc39694341
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 20:59:04.3326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nSDfeAtsxJ+ACHGl124nfZVPMV/Vglg2ybEA+S+BOJ0skGxCgrBK5bid/YHRULjLnSNB4Bn5HLt0CITSkCHz5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8750

No device currently utilizes chclk and FSL_EDMA_DRV_HAS_CHCLK features.
Removes these unused features.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-common.h | 2 --
 drivers/dma/fsl-edma-main.c   | 8 --------
 2 files changed, 10 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 4cf1de9f0e512..532f647e540e7 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -192,7 +192,6 @@ struct fsl_edma_desc {
 #define FSL_EDMA_DRV_WRAP_IO		BIT(3)
 #define FSL_EDMA_DRV_EDMA64		BIT(4)
 #define FSL_EDMA_DRV_HAS_PD		BIT(5)
-#define FSL_EDMA_DRV_HAS_CHCLK		BIT(6)
 #define FSL_EDMA_DRV_HAS_CHMUX		BIT(7)
 /* imx8 QM audio edma remote local swapped */
 #define FSL_EDMA_DRV_QUIRK_SWAPPED	BIT(8)
@@ -237,7 +236,6 @@ struct fsl_edma_engine {
 	void __iomem		*muxbase[DMAMUX_NR];
 	struct clk		*muxclk[DMAMUX_NR];
 	struct clk		*dmaclk;
-	struct clk		*chclk;
 	struct mutex		fsl_edma_mutex;
 	const struct fsl_edma_drvdata *drvdata;
 	u32			n_chans;
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 2148a7f1ae843..41c71c360ff1f 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -483,14 +483,6 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		}
 	}
 
-	if (drvdata->flags & FSL_EDMA_DRV_HAS_CHCLK) {
-		fsl_edma->chclk = devm_clk_get_enabled(&pdev->dev, "mp");
-		if (IS_ERR(fsl_edma->chclk)) {
-			dev_err(&pdev->dev, "Missing MP block clock.\n");
-			return PTR_ERR(fsl_edma->chclk);
-		}
-	}
-
 	ret = of_property_read_variable_u32_array(np, "dma-channel-mask", chan_mask, 1, 2);
 
 	if (ret > 0) {

-- 
2.34.1


