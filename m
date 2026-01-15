Return-Path: <dmaengine+bounces-8273-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6222D24F98
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jan 2026 15:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B0F23300C623
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jan 2026 14:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AA63A1CFA;
	Thu, 15 Jan 2026 14:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MmeYwc3U"
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011016.outbound.protection.outlook.com [40.107.130.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033BD3570AE;
	Thu, 15 Jan 2026 14:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768487713; cv=fail; b=j4cD5/v99Mxtbetqx3Cf8zqoLHZX+6BUZlpJsBeFamtqpslyog2NSUSiiAsOm47oDmsd/N4xlWKPC2dkDQSRX79AnYn28lm9ZgE/dYp67OI14e9POJSy11/gW47EMIPh78HK5OQg9wR8CW+RJviryJRUP8SsFDpQFNi2acRVkYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768487713; c=relaxed/simple;
	bh=YYIEhB4RvGHK8/MV/VwJDdz4X2Q9O3DwC/coUAeAXxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dDlt8ok4HAska4Osa8uA3ef/EJ7J5hAnl+Rt1tP5Y5XjfeJAZqpi70fB8Iqxg6UtQu2WfysMhrmNAGyMzli8+YlBlK4BB+2mnogXOaf5/YJxZSfwOWZEcR1YEykbCcuHJaup2Cf+jYXSSWclfOqglWVQInGqz1hCP/qG1uADfMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MmeYwc3U; arc=fail smtp.client-ip=40.107.130.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eIqVWPLY0r9sBkVZfwBFqSilo2Sj/x5JbFFbaokaLEkKk6TAVVIEjUveS4Gp6VfTKsp6jJkBFDXNVc32Lgw9cMPatX6cYS1ZH6Sr+gAHtDzp3WDVXZvgBsEH+NyzbRL19cb2xKuF+HWDBbrRx+iSc+xAyYFPfiUxxy8VvXxrtCZmTDPLwGm7dN1r/GHUdkVs2ZB8Cp1KHxX1Rj9dFnsATPKIc5bDOKcRKopEdFii2thGU8lp5qNVdfwvQYCP8+ISmt1sCQUXyCcE2wNr5eO7HQf3OXbRqXVjDlNJaGITjqhPaW7KyoNwbb8c6UQYSM3Lp4sICK454qnR2eRcFvQn5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/PDTfYKoE/iwiF9yYMl7f9iOrHmBYKLyEJKl//pTwr8=;
 b=pURdhVYajyyUbJ/uZ7SWgE8K/canzRYLuLc4/KYTGp0sBQx04/9DqA8ohKPfxHCQEkrtfPuNbSt6vKM8PzqWnfohvForOT2P4YmnT+gUeL4PkRoeX0Zcz23QdGL1tvuQqvNm53CNMHpniSttE9sde74/bh8Sd+s0Pat3fU1dLp9+ndpXmg7fp2m5Q6Us+gCtRhnrJ/g9PzzPwxhcT/9BSLUehpTN6gPfe9P2aus5ShzRawTljaBWakMjCFjZPNWj9e0d5WtoXEEopB17aH0b6J7sBV0xL1AzywWItnrjvaXBToGPkhqe/GtdjhtvvBVbSAud0YMLpQ5KR7YKtRPWsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/PDTfYKoE/iwiF9yYMl7f9iOrHmBYKLyEJKl//pTwr8=;
 b=MmeYwc3UNFnfPycXmEyZTHzbj1Vrpj772K4S0N9DstRKP7D3owzZbMtgJUHXjFI/MgYUKl3pmNuY0PJ3fP/eSbNtlO2i9DcduisGD2qxbmE1bfIZbSe9QQ8U5BN1uVArcG39dBYmbDaeijDPW/PnJy8/8XgJXKhsH1uetAfsUucacqF6WUiCFQL6srM/XmdknTO+fi3ucEbYICFEDtW1CjAk4epGUJL2I/fGGnaGUTrI1B/Jpr9UuQF1KVfnDhmSBOmrXPqIgfYaQ3Rv3+RjbAAVBl0KqNxOdrgYBVhchvUKaWyXxaXp295W95M68RotAYJZHOiAMxXRqA1FAI8Qag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8948.eurprd04.prod.outlook.com (2603:10a6:20b:42f::17)
 by DU4PR04MB11756.eurprd04.prod.outlook.com (2603:10a6:10:627::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 14:35:08 +0000
Received: from AS8PR04MB8948.eurprd04.prod.outlook.com
 ([fe80::843f:752e:60d:3e5e]) by AS8PR04MB8948.eurprd04.prod.outlook.com
 ([fe80::843f:752e:60d:3e5e%4]) with mapi id 15.20.9499.002; Thu, 15 Jan 2026
 14:35:08 +0000
Date: Thu, 15 Jan 2026 09:35:00 -0500
From: Frank Li <Frank.li@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
	Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH 02/13] dmaengine: mxs-dma: Use local dev variable in
 probe()
Message-ID: <aWj7FBa1YxSqt/XF@lizhi-Precision-Tower-5810>
References: <20260114-mxsdma-module-v1-0-9b2a9eaa4226@nxp.com>
 <20260114-mxsdma-module-v1-2-9b2a9eaa4226@nxp.com>
 <CAOMZO5AF5-=-2F2W_U9=VbkwtBp2_hzKkJziefLeufD97xNj=g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5AF5-=-2F2W_U9=VbkwtBp2_hzKkJziefLeufD97xNj=g@mail.gmail.com>
X-ClientProxiedBy: PH5P222CA0001.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:34b::12) To AS8PR04MB8948.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8948:EE_|DU4PR04MB11756:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c461544-795d-4e2c-cd01-08de5443481d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZFlxS0lqdUpTOVRaSjI4dVRzYlRBL1h3TTRuR2dJMExqSFNZM2NlUVRIcVNH?=
 =?utf-8?B?WklRR1E3d2F5czR2WUwwSXR1RWZxeXYwbUo2eXdYMTVuT0dhdkxjU1htdXNB?=
 =?utf-8?B?R1N6T0hKV1dMNjh2MGNsYTQ2RkdEU2F4Q0ZWOFZ0SHNoZzlJK3hoZnlnTFBn?=
 =?utf-8?B?b1prRzZ0clFWVFV4V2t3V01iWTBMc25xcXNMTXI2N1h1bG1HLzJSa3FrTkpv?=
 =?utf-8?B?bm1Yc284QUdTNnFnZ0drZHJoVjg4TmVpUlhWYXhTWUFHdURKTUVndXJmOCtH?=
 =?utf-8?B?dzB2YVFqb1hzaEZrelRFYm9WRW9zUjdrQ1BoN2dwQk90eGlaOU92aWRIYis2?=
 =?utf-8?B?cjJJVjdwOC9zMGRUVElqS0xtV3RxSGgzeGMwNUwyM1NXWkZhYUZMQUM3dVBK?=
 =?utf-8?B?RTdSd3VlNXF2Yy9JMnVyUTRiWUk1bUdFT0s0TEFEVHIxS3praHVVMGp1UUVC?=
 =?utf-8?B?NGR0REx2NUxCZFc3OEhraDRLWlNndkVhMGJ2dUlOZ0hUUjB6M1RJU3orTWQ2?=
 =?utf-8?B?YzhuN2YxbkxnWGFVN0ZCU2t6Y0RRbzV6em5HZUtha01IZmlUcThpMEZVQ1Nh?=
 =?utf-8?B?YWo0UnJTSU1yTi9QdG5Ddm1nd010RGg1Qjdac1lWc1lhWUxoakZ1S0xyeHhT?=
 =?utf-8?B?K0RzM0kvWlBDUktWTUVSdnZYNUd3UnFrckM0MU1wa2ZsS0QyUnFLRjNzcFRj?=
 =?utf-8?B?SFBIQmFWUFJuVWlNNkJuZ2c3NUROOXdTcTExTml3Qzh1bjVRS3VXa1BORk51?=
 =?utf-8?B?V21EMGtYWTgzRzlOQndMOFd1NEVxTUJMNU5SWUo0YmludjZDTkVzZm1Qd2wr?=
 =?utf-8?B?eWhjMDB4dFpSZDFKSFVKalQyMmZzZzJOcjNnOUdUWGtOT2ZzdGF0ZERDeE5C?=
 =?utf-8?B?WXo0dXJtMEZiNTAydHdmcStnQ2hCZGlUbkRkQWlmcG1VOVV3WlBTNjJ1WVVv?=
 =?utf-8?B?QjdwQkYrL1NvYlhWcjBJUUJSM2VRME1MRDFEVDA2TEFtQXZ6NFJWcFhNaXVa?=
 =?utf-8?B?ZmVhMFllK2dZbENsWU1pMmg1cHFpMWtnaDJkZU1PS3A0bStFRXp4ajR3LzBa?=
 =?utf-8?B?UjhzSHlNTFJBMEVFVWpRekxBdHgzWW5ZaGxLa2E4cWsyenZ0c3Vadzgzdmg4?=
 =?utf-8?B?MmRyWFZDM041RTJRaDF1OFZiajlNTG8zV1dMWGlYMzh3RjVlQjgyeVlrSkRt?=
 =?utf-8?B?aHRrc0pWY3Y2L1BtcWVpMUMxQWhqVjNaZ0JpSHU0YW96UUFUQ1BCOS9IRmt6?=
 =?utf-8?B?aGxEZ0Y3SXVPT1VTMXJNcjFxRnlPTHkzTE1iOTgyTUd2SDdueXN6TzVrTzJ2?=
 =?utf-8?B?MWR5bkkxN1lnQjhVWmpZbjZYUE9pWHozczh1SXRPUFRKcitFaDVSOXV6em16?=
 =?utf-8?B?ZEh2TmdKT0ZWcVJJbzN2M2FLK2lyMU9LZkcvR05HcC9renJuRnAweHMwYm5t?=
 =?utf-8?B?OFE0T2wra1Fwc1JkdXFEamMxU0pjdm8rL0tnOU5HTFpKcVZlQ2FVR1o1QmdX?=
 =?utf-8?B?L3czZHhHQU1ySjFRUGVIKys1M0lnV28rRVVRdEZwWHo5YThsSExNQWQ2NG9i?=
 =?utf-8?B?ekQvM3J6Ymo3Um1aa212WnMvRXFqcEluMDh0SzJBcDc4QjUzbmNWcHE0aXZz?=
 =?utf-8?B?cStzV3FCMG1nZnpDQ3pwNm55SzhsS2ZRSmhDRmNYeWNkaWgxWEdZVGtQb1pX?=
 =?utf-8?B?UEJEeFhnTVgvUkU2aStwczlXTFFnVVgzRVJtNTdpM0NackN3RWJmQ3M5Rkhh?=
 =?utf-8?B?ejdJenpYOE81QW5TMkFDUjZNN1BaVHZ5azVBR1ZlZVhVeTlwS1BzVzZ0dSs4?=
 =?utf-8?B?YXJzNEF4Z0tZdzBIZDUrb2s3d2FsOFMxbGMxUEJVTG9heHQyWjY4UUsyYkhO?=
 =?utf-8?B?YXdXLzFVcXVBR3NmTzFtYmN2Wm1jbWRUT0Y0MlhJNkhCMm85OWpacjQ3S2lH?=
 =?utf-8?B?VjN2MU95ZWJML1RnZWxoUnNBUEVidlUybXYzZ0l2L2tUZExNMlhGRnRiNzJX?=
 =?utf-8?B?M2E0cU5ydGVONjU2UDhwVmxqMThRenJmNFlvTFNjWlVKVUNWYXpVL3RUR2hm?=
 =?utf-8?B?OTFMSkFZUkd3eS9TTFRWNldEeHFkQWJ0YzRyakFNZ0FUd3ZvazFGRHYrbDNV?=
 =?utf-8?B?SVdlZ2hlWk1pcTNybTJOVmd5UTYxcklIVkdJdHpiOVUzRTBnVUhzOCtlSzlH?=
 =?utf-8?Q?NFHIrG8EUF6K9TlDpIpkk1I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8948.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWZJTlNwVDlKQXBtZHp2MHIyUjlzUW5OTG45ZVZLTzUxU0NqYmNmY2d1WUxy?=
 =?utf-8?B?bk1oa0REOGlKdXJCem1oNGRHMnZ2TEZvNnVLaVUrNEJaMzVMeWpEcjlvZGsr?=
 =?utf-8?B?MTZYOWliR3oyT3FVYUtTakZKVVpxQ0Rlc1pmcVBSTEZOV3JjaEdoTmVFQ21U?=
 =?utf-8?B?NXR0S3hKMThxUzlueDVsVWUzKy9CNFhyakhFYnNoNmc5RWZyTUN6SWNCanN4?=
 =?utf-8?B?cElYd1BjK1h0WWxLbG12R3RxenVjL2tLUXVORVNVNmNQY0o0dWFNc0ptQ29n?=
 =?utf-8?B?eGRKV2YzMWEzc3NHa0NrVkZQWGJqV3E3YmNqS21pOVR5K01RZUVla050Z081?=
 =?utf-8?B?aGh2SGg2amtPcWRvZUg2enNrNk1YYXZ0MUdHR2UvK3Nxa0RzMkVvaDkxV0dF?=
 =?utf-8?B?em1sTTQ3UU9tWUY1VERCWlZBWjUyRi9RaS9QcFY0akZXOGhiQnNhNW43NnNO?=
 =?utf-8?B?VkVFaGROQzJzVmFvb0ppSERZVWp5a21KWW1jZFIzZWN2TWlCTXViNjBoYzBo?=
 =?utf-8?B?VU1Gd3NncjJHeWd3TVRnNGtpdXE3bHhnbTF5OWlIQ1hNYUtJRkxkNXZYL2ov?=
 =?utf-8?B?S2poK3B6RmtpbUZtc3c2VUVKMEc4TVhKSE9KVzllU0l5WFVGR0V1VlNpR1ZP?=
 =?utf-8?B?alF2M1Q5Z2RzZFVZd00xbzRPL3BXb1loTzRxaHpSNy8xc0F2anNwcHhiVFlB?=
 =?utf-8?B?M1NxL3JpOTN5UjlqeEtWd0N1bG9hc3VZRmpha2V5QzJPbjJPYWNRNndML3Nt?=
 =?utf-8?B?Y0NqSHhBNUpMNzh0NExzelQ1R2ZwaEVIdGo4RElWSE9HenFKQUw1K1Y0bFZq?=
 =?utf-8?B?N0dWTW9xYUpHMzFTODBBRmpSeTZRMTFhd1I5bmpMamtpRmFrbFB1VjVOSG9o?=
 =?utf-8?B?ZmgxbzZ2Tk0rdHp5THF5UXZwRkRnWmJKVzNJQzgrZFNXc0dWVjkxcnVnTDBU?=
 =?utf-8?B?WXhHTmtBOTY2b1BGdlBWLzc4WjRYUVh5OFN4ZUlEZVBvVG5TS0RYYldrK24z?=
 =?utf-8?B?ZDNPRFppTFJqbVJiQ1pUNGFFSWVmeFJ0blNRZTFkOTJqWi9SczZwcmFlN21D?=
 =?utf-8?B?RUJ1MThMdms5MDRQT2JMSlhsNFhPUE5iUk5uZXRLOE10MUdqUVJDeWhxQTFq?=
 =?utf-8?B?cEMzSlg2Y0kycTJ4b3p0SWhjbU16bytKNU1ZUzl5anplalgvNU0wa0lMcUho?=
 =?utf-8?B?VHlPak9BYmVzYWs3ZnQ5TUZIMGJWSFNvK3B5SWhnWkZycVJmOHdWZUx1Nm1n?=
 =?utf-8?B?S1hoUWV5WnRtUzBnWTBTMExpY2RCck81cEZJNWFPczV3K085VVNoYVFXd2E1?=
 =?utf-8?B?Kzk3VFFieGFtVHFkanVxWCsxbHZ4bXgzVGsyN3V3UmhodlZXT2RXYVpzdDRX?=
 =?utf-8?B?ang3RWY0SW13VkRTM0JOdjlPTnI1YWlXWjRnbDBjTFNLaUg5VjAwVGJ1WXNE?=
 =?utf-8?B?Wm5RZEZaeWRiU29ndGpKbG4rTzBHL0RxcTZFSE52QnVGVHN5S0dxdHNTMEF1?=
 =?utf-8?B?RFVYdllGUDdWT0NkU1NweTRDTStjamRLTFAxQjY3aXNxMWw2SUIxK3dBaFNV?=
 =?utf-8?B?VGNNcjNTMk1qcXhWdlNxWSsrQTQ0RHJkcDFuN0M4OG9WOHFBcEQ0RjdFUDBL?=
 =?utf-8?B?VUlIaXN5OUpyR3R0Vm1vMjBKTGFKYVBSY1M5SFJRT1dGdXNSZnhla082bk5K?=
 =?utf-8?B?WmtjSSs4azFmbWlNSlphMjhXSHpxTVZkRjlmbVQwT1VJUnNqeUh3a2VKWDE3?=
 =?utf-8?B?S0hwckVpY1JDWVBzWXhYT3BkOTgwZHNraThRZlFDOEZFbk9DZVAvaFRjbUhi?=
 =?utf-8?B?bjRIeTFTRSttbmdCU3ZjT1dRb0dBdEFKNXRoYXRWNjEwSWpEa3R6ckIraVdO?=
 =?utf-8?B?TVNma1hGM01wNWFNaUFjekZMUzI0QXZuTUJraFJkOVduT1VyWGFVYmI3eUEv?=
 =?utf-8?B?K01Sc0hzVWxRclM3MUxDaEZieHYrY2psUjhPR0xKVEdiY3BDUksvNDBGV01N?=
 =?utf-8?B?SDllbGRLSE9uRXZUdVorazZrNkVmSm9sdFpxTi93bndJTlp5dit6bzhuV2Rr?=
 =?utf-8?B?SkplZXArSWpkdnhib0VMdzZaUlhzQXNPT2s3NXBPSlg4ZjE1a0kxMW1WMUdQ?=
 =?utf-8?B?clY3OC90Nmk0K3VQRnFJVGFBaFFUb2VXMUNjaHUyS3RYaFN3V0lkNHVaUEth?=
 =?utf-8?B?MktNMEx0QlNxeXlDTy9DaHNZelhOQTJJN3ljS0VUek03bThFUDRPblhsSG1C?=
 =?utf-8?B?UHA0TnBFWUxvQmlBc3Jvd0wwN095ZHh5Wmg2cE9lNWlOV3ZTWk13M1lYZ2Rj?=
 =?utf-8?Q?Yi0PV0+1sXzTfsh3me?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c461544-795d-4e2c-cd01-08de5443481d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 14:35:08.4473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GRZGh1o9576tEeEdI1u+gvKE8bhh00jYAT0ixyJq8Ld6ykaZnn0nNbF+4bWuvFf8PCqPguBFjT+k882kbLq9YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11756

On Wed, Jan 14, 2026 at 08:27:18PM -0300, Fabio Estevam wrote:
> On Wed, Jan 14, 2026 at 7:33 PM Frank Li <Frank.Li@nxp.com> wrote:
>
> >         ret = of_dma_controller_register(np, mxs_dma_xlate, mxs_dma);
> >         if (ret) {
> > -               dev_err(mxs_dma->dma_device.dev,
> > +               dev_err(dev,
> >                         "failed to register controller\n");
>
> Better put the dev_err() into a single line now.

follow patch change to use dev_err_probe().

dmaengine: mxs-dma: Use dev_err_probe() simple code

Frank

