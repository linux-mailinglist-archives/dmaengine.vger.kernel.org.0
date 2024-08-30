Return-Path: <dmaengine+bounces-3039-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFEF965D32
	for <lists+dmaengine@lfdr.de>; Fri, 30 Aug 2024 11:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A591B24A3F
	for <lists+dmaengine@lfdr.de>; Fri, 30 Aug 2024 09:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1E416DED6;
	Fri, 30 Aug 2024 09:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="nDl8bTys"
X-Original-To: dmaengine@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2078.outbound.protection.outlook.com [40.107.117.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC49017A931;
	Fri, 30 Aug 2024 09:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725010901; cv=fail; b=Q2lfYCgEnojVX4KN4lKUzL+TwF3JL4dIWb+tCoLkRxLSV86Dc/R5KKWBWjxk+jkywAcUvqFpGaQa+pN+COzsFEwIlrt/3kSPZltJff/YOfOPNib0XK3rXjeYTYN0V/imZuia8K7wgX9SnInwMgwVuX1Cz2sfeFsURPttihIYUZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725010901; c=relaxed/simple;
	bh=jfi+PYlezXIYdcXyXSsJ3qi3KooHAW9FCaDEaPD+Gls=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZM7tkPDjzpj+xzdoeBDHYH+dNkoypNjBD6T858+MhVzaim39dtpNGAc/Hz6ygWffF/SfhwFT/RTA7yNaV5w9tn7p9KAifxmPBEnDwCpm3fToQb3xLBC92YUYUGQCzvMRkHgSc4OJJmzFQljWsgG6X1oxmvCZnGmq2JRoYfh0M88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=nDl8bTys; arc=fail smtp.client-ip=40.107.117.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vp5nH/1aBwoHZf2baCn9WQIe8Usx5WKXii/LOE91VHX6I1rPV2fw4SiUyzKuuhLXbV9q2iRfnkKQaDKcRI0H6DRWsRck/rTLw0kb07Ayg7VySChpnIF76kvduGIHIHEioP2vZruLU3XzYeYL+v/gyrBvddDqNAcGNWdorzZsI1uWjksNGl8fUFOoAlNzJn5Q7m7N3EWIh0skhVF1IXWyoWhHu4h6x1IcV3/W9HFsRdp2jx4gsAv+Jhgb5YiVOH+zT0IkqU6ktec8kUNMf6WC9tueeU3+HCGFElzyuMHTdHxUYESohDiARU0AfCR+5REisA8GchR9WM8ZFlDYnUkk3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xs7ILw0SU9agNB/gUeCNtevHvf0OowZW0mDlK9ZWENI=;
 b=giwRc4IjJu5NrgSuIwkoRweyvOw64Rfl/Vv6V/YytwB62w1DvuvALiGV6/B/TjsxZQ1bX5b9TEQ/HeGawMLkyumHwlIczga56auHSEp2HlogK+1hVr7AOhZnHSvW/RmZ7DtAvkdrvQnWPgaVtUqhwLnj/MGVO5xIy7Km+fSxo08X70mWO5ckCje7otq2qR0X9mzACErSLWHyGKzDHiPmNNpRI6TzsKZDysRCHzC1kw1HdM7c+FilmSGHnD9MDCEKto9WxRC+FU7FYaAZ3oHhz+/7cn7c/H7Pwqo7ePaxPksOkOnCVCsWgtC8gNyW6hq7YsUXGoDbM/tGsPWisp3DLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xs7ILw0SU9agNB/gUeCNtevHvf0OowZW0mDlK9ZWENI=;
 b=nDl8bTysnaroF+G2Z4B64cygNv1O44LUD6SXy98uDIvC9KizL8sTwlutOj7+Q4E+OIEQ/WNE/aygvlmMPO2GKESKowMnO6WedhLf5B28y68wIi9j7OI1EDFMdstsyPbXSZF+kIBuQa9+PhMRhSyVQMaugne4z46/KCnrcxtczjRhfHJ+APRhrPMx0NJqqPXwMunrp4wEZ+DT3NygEm7eg2o54+EOinSpi0IxDUSStpXutfsID7y/pG77RqfPwPFwoom3rFZIh40ntrFoU1kOH0W7tMBNChtNqtctOeL3CO0Et20A6oLiEURgV0+81kDioz/tjjHApVWsputgPV/k9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by TYZPR06MB5203.apcprd06.prod.outlook.com (2603:1096:400:1f9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Fri, 30 Aug
 2024 09:41:37 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%4]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 09:41:37 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: vkoul@kernel.org
Cc: dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH v2 2/7] dmaengine:at_hdmac:Use devm_clk_get_enabled() helpers
Date: Fri, 30 Aug 2024 17:41:13 +0800
Message-Id: <20240830094118.15458-3-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240830094118.15458-1-liaoyuanhong@vivo.com>
References: <20240830094118.15458-1-liaoyuanhong@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0020.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::7)
 To SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|TYZPR06MB5203:EE_
X-MS-Office365-Filtering-Correlation-Id: 70b3775d-4135-40a8-ecb0-08dcc8d7f12f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/fMZ/H4liln4i8WU6KPPL4MvtXgLwULoFsWE5fChkIq1Ou+ByZfiGY9FbKCy?=
 =?us-ascii?Q?y8NujH5UerBCLpG9AfvrNQ9X+b1BhaHgBVWmiW77VhYd1gzAqZIOsdekRJwN?=
 =?us-ascii?Q?YfmK2E2nMjrV/6Ce+SMJ5gBrv+x1hMz6m4r6yHKsZrc1oZ+BJrqeF2z5GsmE?=
 =?us-ascii?Q?dtfC9u75LKUFQG1rCTY2cWKtUypkE9EefJrcbRGDlX5fIErJeQkSTBdMijHo?=
 =?us-ascii?Q?aiLYxxVH4oY1cCreX3zxicNKZqE1xvbuPUqfwCoPAnmfY0zGW6Wnm4T43Wcf?=
 =?us-ascii?Q?QIA5MGhnEHAx+uWguQZ3DxmtmyPJdbdQ32r6EroYtI4HTriGJaw/O4HzSZFC?=
 =?us-ascii?Q?LsiCDQfGiuIzlei+0AFyDvN+zRY/x4Y4iGum267s8Ga6F5srByZjSdBR2MFf?=
 =?us-ascii?Q?nD5KfXxWurUwDY/nbMKt2fmuv7pxGtGxBbqNu2laio2SCFjOZINmUYtuAAWs?=
 =?us-ascii?Q?5jMVDO58Sqj1RlxMtSQFB6Lm1VvT4Z1qoeOXanXab3ExVmJhTZntED0kJuwp?=
 =?us-ascii?Q?3CgtNk/dA1u5rSCQWPPanBfxVgf9NoMdmboPKi/fSdFBF0FUyR0E/THjM2Lg?=
 =?us-ascii?Q?K9BS3Mr+jx/aO3BGI7JsNb0AUTv2iOvGYIk2g/J5I41Tk+yNP3MdWJmHsgWv?=
 =?us-ascii?Q?q8JiQCN4c1JzsWPrsUXvWE4QHc+NKG+SsNzG/Aizhvpma2mlsIEu4tlEUL3I?=
 =?us-ascii?Q?FRnXFz1u/Da/2OKmHPJa91Mwypu6sVIPb2qH05DQkOsHkNhRO2tFqh6yXE2w?=
 =?us-ascii?Q?U9vAb8eSHV0NjS2M5prEAgFkFBHkxrIXDyJSnytK7pMz0qVkxPwu2RnHGyMI?=
 =?us-ascii?Q?AyFSBrcP/TnNX6FQwLl6m0Q+raJA+Xv2vEUBBUo4kYlhfB+WDcM5qF3ZzdeB?=
 =?us-ascii?Q?JZ+YyJcIry74SKkdwhs8/NOUumkWkL1E+HeepA8LBJsBbfGlwfJMoybgyMTL?=
 =?us-ascii?Q?auBxH8dqJr+x5JM7bHzuyyIf7Vf1fmfwNuEe6/1wi5p0WFMUcMlBNC61HK1v?=
 =?us-ascii?Q?veKIXjmIylCiQFELAHGTZxNEr5M7A7JCIEjb/2Tu7+QHQe/BuL2E7Ua5kAfh?=
 =?us-ascii?Q?PMlZ7ut2uWQJKkph4PYXfRyIsG52Mlgn/om66lhChQksW5Efsldc5DqrCa+f?=
 =?us-ascii?Q?65HOvSGASaD7eBqiRqW+JpzWUbXam+v6gu5E8UGOM/IfGxVbH3xhMziT8sQL?=
 =?us-ascii?Q?+cQbxQlgdn3HakmYqKe0InNQNtROruUm0se6VuB+lFCTlKLmK5MRZ1s/2Mb5?=
 =?us-ascii?Q?uKyvJcViV7CCD4n4uajjAK5P34BsAO3O46U7W4nGWoS8ClvK09bvQbf9bZz1?=
 =?us-ascii?Q?F10q9P0EmxVWVSGjMU/Nq0cfLUsvjP4mGAkjb3KNxi8zhOcMImpnbQwwKU4S?=
 =?us-ascii?Q?yqtBPMJs60zVy1kij8sFL9Nt6nPNAsdVC6OdZ59kwrrvadFRqQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dTdyAZosUHjMnsdEFb6i+8ApzamNBWH/bKY+buGF6xhIeMu5ykgnDJQ1maiW?=
 =?us-ascii?Q?FWPhfGTSW0KMBxv6y0FFeACVRXXqN4foYNfAD9x4LBh8mqNC2SLjvavWtOdM?=
 =?us-ascii?Q?2LcpjGH8D7VgRP3E+kD8N84JYRAzpMQyFjNt+BnXRhc1CD9wznz82kc0b4iA?=
 =?us-ascii?Q?I7yP2eEETqggJdpEZDv/NxRLPN9E+vQEZV2BxSq/mpW36td0UVowbS3j6b1Z?=
 =?us-ascii?Q?QIZkXfntP/W4NBmUr/83pPZej5OsvFvAPJksEbrhw7GNBMCvkOeHP0i6XxGK?=
 =?us-ascii?Q?LkISXMZ4ONXQGDoHT805SvmZZRgTA6xXuTAM4xRNsYHiF1n9aWlaoG/8os7S?=
 =?us-ascii?Q?SDPsFQd9Tqqv1cbpYgcmXAI3OAnvI5h/dbgL73vSq9czggXwbx2Hg1+EHLb6?=
 =?us-ascii?Q?gtXpjGuQkZ1qYTlYg4KQvBaUlEHkgHFMQuAO+GMDKnbzmTUHfNj5PzOTZYqw?=
 =?us-ascii?Q?bmyuZyBb3YC9YrMiCTUgp/cDcHlNWT0SUXu37v0MyLek0Bxa/0IYmrzzrf16?=
 =?us-ascii?Q?00IDMyJcteuPMUMtYAuF+LQkSXtdHDO47BaH59e0YctHdhsXeqGmOK5QgkFN?=
 =?us-ascii?Q?Rwyl6AnW8jNSbMqx2BXFPT1PMc4c0+Ne1/2EoJlrflfJ5Cak/I3roDMQ2zWm?=
 =?us-ascii?Q?xX8+ZIxxpstKdMOAP2Kapc29gYBZSw3M+xNYRZjbzWkDU5nmRU1k4ejLbqZ7?=
 =?us-ascii?Q?3W/0oDoorPyGDINoQbNiuVe/ALEF1fuVRgCa7dywY5E0sF8tQFMa0uLzvUvU?=
 =?us-ascii?Q?hMqP0uj8Cm8y5Qc1KazWUJlJmiH7MdOcUfItDOeAp5oF6VGRndZLAElxV3fh?=
 =?us-ascii?Q?EDt5zI9wBfG/g+Q9gPOF0seXihtnLjKcEgOQK0CHIxfDrWaFYAzj5uw3JPpk?=
 =?us-ascii?Q?A6vJ7/yH8EDK66g8vcA3bI03L7Jj6cP20JZOLsK3sqbEpvsIH+rmFI1Srxgp?=
 =?us-ascii?Q?yCXwip3O3wWO6BIL8ABaOEN24a5Mlug11ZCcUAWLNB1r2eDU5gwAC1DDktQ9?=
 =?us-ascii?Q?yzA8WcNkmmpoBsCS6YumUrmNyu60EhmVq4hPNGV7cg9RN9Jw4u8tZVa/txil?=
 =?us-ascii?Q?P7myGPN4+tMrm3RAunZRLumRysyg//jeeGehPdidX1KfiIDdD1eDtA3EkPz8?=
 =?us-ascii?Q?T9JWqYv+Efn3b+MN/O1k9e1UdnnifukL2uzpKSO4DPPeLDSZYa+lDR0cYuy2?=
 =?us-ascii?Q?KnM2iU7jjHhV3BFbm5Yy2Mc0/kjL7Sa448eBw3SmwhEZ9mAWKmofDhvoGypA?=
 =?us-ascii?Q?X0dPp0VpM0cUyuecBkiPfHqXcfO0ERdS0pHRU/S7dBXz1ssWIcyk7WKvQbpy?=
 =?us-ascii?Q?Ynawo7Joq5tTFiWsjyxc39IXIal7rsAAbk1GiHfpZ7xRZEBwmavEo9uH/tiZ?=
 =?us-ascii?Q?vPZ3/32tjvXcBI7UK2H/i7rCTpTPKE6K5qKx0RoiF+EmeAMgvrwPpSms8Tf9?=
 =?us-ascii?Q?+63n49CXJD8Jv51ATyelkhlVEzyq4g/Fb8FmBDWwbZusIaeZnidej7xJsgJq?=
 =?us-ascii?Q?Q15hHHK7qRwcs9tNMK1ac6ixTBJRH7DGeMlMzAKplv98LGRbxTX4pgYRQu/r?=
 =?us-ascii?Q?FAOl28pVA+/15VrKCWe++5INmzJtSBuIDa8J5ZRE?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70b3775d-4135-40a8-ecb0-08dcc8d7f12f
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 09:41:37.1321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: itNxbKJ8YjB6J7XNXMBX4RLR76wvwjIQsJEUKOLkKTuLt8w2E+qJt+nieHy7CXOGNBkMD0nTw2U/Mm60Rf4sYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5203

Use devm_clk_get_enabled() instead of clk functions in at_hdmac.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
v2:remove modifications related to the resume operation.
---
 drivers/dma/at_hdmac.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 40052d1bd0b5..2274aeb58271 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -1975,20 +1975,16 @@ static int __init at_dma_probe(struct platform_device *pdev)
 	atdma->dma_device.cap_mask = plat_dat->cap_mask;
 	atdma->all_chan_mask = (1 << plat_dat->nr_channels) - 1;
 
-	atdma->clk = devm_clk_get(&pdev->dev, "dma_clk");
+	atdma->clk = devm_clk_get_enabled(&pdev->dev, "dma_clk");
 	if (IS_ERR(atdma->clk))
 		return PTR_ERR(atdma->clk);
 
-	err = clk_prepare_enable(atdma->clk);
-	if (err)
-		return err;
-
 	/* force dma off, just in case */
 	at_dma_off(atdma);
 
 	err = request_irq(irq, at_dma_interrupt, 0, "at_hdmac", atdma);
 	if (err)
-		goto err_irq;
+		return err;
 
 	platform_set_drvdata(pdev, atdma);
 
@@ -2105,8 +2101,6 @@ static int __init at_dma_probe(struct platform_device *pdev)
 	dma_pool_destroy(atdma->lli_pool);
 err_desc_pool_create:
 	free_irq(platform_get_irq(pdev, 0), atdma);
-err_irq:
-	clk_disable_unprepare(atdma->clk);
 	return err;
 }
 
@@ -2130,16 +2124,11 @@ static void at_dma_remove(struct platform_device *pdev)
 		atc_disable_chan_irq(atdma, chan->chan_id);
 		list_del(&chan->device_node);
 	}
-
-	clk_disable_unprepare(atdma->clk);
 }
 
 static void at_dma_shutdown(struct platform_device *pdev)
 {
-	struct at_dma	*atdma = platform_get_drvdata(pdev);
-
 	at_dma_off(platform_get_drvdata(pdev));
-	clk_disable_unprepare(atdma->clk);
 }
 
 static int at_dma_prepare(struct device *dev)
@@ -2194,7 +2183,6 @@ static int at_dma_suspend_noirq(struct device *dev)
 
 	/* disable DMA controller */
 	at_dma_off(atdma);
-	clk_disable_unprepare(atdma->clk);
 	return 0;
 }
 
-- 
2.25.1


