Return-Path: <dmaengine+bounces-8636-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFhSHgpFfmkFWwIAu9opvQ
	(envelope-from <dmaengine+bounces-8636-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 31 Jan 2026 19:08:10 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE60C37B1
	for <lists+dmaengine@lfdr.de>; Sat, 31 Jan 2026 19:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F6B9303C015
	for <lists+dmaengine@lfdr.de>; Sat, 31 Jan 2026 18:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A76836605F;
	Sat, 31 Jan 2026 18:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YzKgZtNy"
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011004.outbound.protection.outlook.com [40.107.130.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5A3365A15;
	Sat, 31 Jan 2026 18:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769882875; cv=fail; b=Er3mpg0rY9rK4vUb7Ouva/Pkoe4OOy/AzJN3mGdznzlgCBNQAb8CmJ1OsAn4fRaYrQ5GYGeB5gR51lEU+z1ZcS00uoDZthKd85sner+CmAUZb/B3hTNlFiNSA7yB1QfM59BgiWr+WJ1pn4Vt0qUluuWAHftJHSoHzKwgkK7v36w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769882875; c=relaxed/simple;
	bh=YOjSIFoLwym9PyNOQ2UnnfJE4CoBDESFNkRpSRSihPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I3rQy9wnEDViyihE4CUzBBl0sUOiXh6ALE4xus94Ls/oETdZVAYBrNMTC4i8xJyelHYmKGCZLpTxvuD81NkhFtaUgyitooskpwsAs0c8bFSGOGYtif/yxdMka6XHsYQg8l4R/nW4c3dBzoRYPh6mU/I14XrQQFUBVgHa7oTWa1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YzKgZtNy; arc=fail smtp.client-ip=40.107.130.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CrgnfDEjGxQc2H8MIJmZTOHu1IDuYd13s9JwK43bGFUIlGHFftQjcpyZuUjQABTVvW56Q1pTbE++Q9Y/W32/mahnfzwqLVnzF0tJkpMEb15q1uzkBNL3wkRCMYekN8T9Jn42DYAiDY3m7nWvBCm8ZqriFnGWhRKf4zWIphfGlCGWKBA1PJ3o78WutrF23Dn5lNWoXE7SzPdqAy52ODrv9kuS3CgwH2uqE1fmZCMClGrDXfWQyg+Z4H1+hpC2LDbJtN1VKTjC45KMtCLpCf62C482nNOQUG9AoJjZd+nF4jclETcoCJ3AtFgV24R7x8mmZgyatRs28xKHGb5kkchVFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9pqY4O0AMFe760w0ksRsLKZW4tBdVLl/Glxuf8Q7I4w=;
 b=s8491XWR9ynEDk8dr6ZIo+HUnLwSOnZJVXer3hbAAurzqX4mzPqhShvMN88Ceh5hreaWhVFO8jfVB5nS2d9vNfV7rfbEgSIJahHl2ZKccDwksvygMyRJtxBjNH7cFI7prqBw214htRGDg4TuaWTeby4z+ujCck94ZjKU8vlPZ1KyeN5UIFfJJVWuLqUxeH8wDTWK+Q5AIM2EydIM614gcQHZYVPKAyhs43/FPdSxaTmMvxcR89qNhD+UQVezyHZGDjYVXZhljrkLhFf17UC3CbOk1jvxUud1RQkrjJsOEHMg6BCZShVfWbRrEKUWeiqlEGEMiTYawVU/iXW6Jw0OaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pqY4O0AMFe760w0ksRsLKZW4tBdVLl/Glxuf8Q7I4w=;
 b=YzKgZtNybXIsoClTUZdqUgfLdroHWIg9yTyF8iW5NurJwyYaoiu1blaV4Paj8xcQvl2O3Bfe5lSukPguzfChdq+3177Kf5swk7oWj6DoHCm9IIuGxBApfM2NrejTuuYlWiaM8g0qqUKXOFxw0mUUyPTw2D+/VIp3/B+UVjTLbrRIe8oVprtLYLl18lZtS4u8AIWuDEqBPsItWE5me+qA/EpN0osTnjdCiHwDVrb4PZkBn+9yQx4JPqoyurrsgy+0vGY0twe1sFfjghlHgBbd8TKyici3hyqumGHZVJNP6VifX/6SKXDUxtopWeZJh9qF/hd6g6+x77VWP1UCMJvodg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM7PR04MB7189.eurprd04.prod.outlook.com (2603:10a6:20b:116::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.14; Sat, 31 Jan
 2026 18:07:50 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9564.010; Sat, 31 Jan 2026
 18:07:50 +0000
Date: Sat, 31 Jan 2026 13:07:43 -0500
From: Frank Li <Frank.li@nxp.com>
To: Shi-Shenghui <ssh.mediatek@gmail.com>
Cc: vkoul@kernel.org, manivannan.sadhasivam@linaro.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	brody.shi@m2semi.com, kevin.song@m2semi.com,
	qixiang.zhong@m2semi.com, tom.hu@m2semi.com,
	richard.yang@m2semi.com
Subject: Re: [PATCH v3] dmaengine: dw-edma: fix MSI data programming for
 multi-IRQ case
Message-ID: <aX5E79YgjTrbrgVi@lizhi-Precision-Tower-5810>
References: <20260131104550.1088-1-brody.shi@m2semi.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260131104550.1088-1-brody.shi@m2semi.com>
X-ClientProxiedBy: PH8P221CA0038.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:346::9) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM7PR04MB7189:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e213c1b-eb9d-4dbe-efdd-08de60f3a583
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|19092799006|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RDBCd0xT0yTQ5QbTLp14ybUuiZfItrDF2/gNVjBPNDOCLbrhjfvFVVeUCDOV?=
 =?us-ascii?Q?td4waO8UjxZDmOvKh7jvunXQ6sA0O/1gV69JTiFvm6dEYv84tuzox+hn9TW1?=
 =?us-ascii?Q?f2B2ffjCtpJ+fg6XnkM6CGJrAMsAe8gFjePzkpWJm+EBgifRjPJWYKlplCcK?=
 =?us-ascii?Q?1UAXeQIkNx8SdYz0cn4n8yh9nQT42xs8X1H+tbwSZZwdYXXKSr20wQE0Kj5w?=
 =?us-ascii?Q?ZFIybBxVJ9pJa1Y/ImJ/q5NwIZoILIh6ouSxsabtKXSk0O3KzKPwVTX/C/+a?=
 =?us-ascii?Q?vNI8BX/UZy9s/E6/3XbqcmrBmPnyqOPMFpOJTPpsLb+nhPLpTgQDNokQllRp?=
 =?us-ascii?Q?7Dr+ooSc88L8GczxnSRT45akwnTjwf0AnH9bFBuYbcjSO+5nRFbSkz+ZozFR?=
 =?us-ascii?Q?ZFZ/m8t4lzkPAArevTUQtVy8bupSjTMth5FTsUahEGjyzzJkYry2duEgDwEI?=
 =?us-ascii?Q?u4XyF7mxlJATePwnE8qw6u3GsD9ZwsxvZ2PwtvFGTPlrWWyPiJwczDtwvrjX?=
 =?us-ascii?Q?wU7D4/atwx+0hqh3eMrPO2/L6EvW7p5QHMQJZqNXsB1D7TdinDtWq+9ZPOke?=
 =?us-ascii?Q?wb5QtpedMkp4HYP88T9KyQSPtZfd7QNZpUGYh8ronwEa+UamxcmgyjtvMxkr?=
 =?us-ascii?Q?r+hVnGi++ikUjpbm7XEboeIjWORNPBLf8Mpa72BBUVU3GJ5kiVQfm56vCCL5?=
 =?us-ascii?Q?Bkis1SNbpWX8pLJ0ubs4NBESSOj3bWPRgbaxFFESFicn03+e/sjzlHRP0tid?=
 =?us-ascii?Q?qYLy81otjtCD1jc/cKeF6xmvpvWlchaiWRmI6Ir7bv7MHXtqcAYHWsfSAjQ9?=
 =?us-ascii?Q?/MIETQN/aivABifw3wlSxIm8f+cMjc0AKCPJd5vBzoZnY+5EGyIa/YHb1xec?=
 =?us-ascii?Q?NQVe8ewhMhwDkikO2Eun94UIAL2XQFmfsFJ3MOR/LG9IP+m5OmBAxU5LfOHZ?=
 =?us-ascii?Q?HLxAStdko8gEwz8UCRozxkDM7Cqe9T64R/YHJ2R5n57+cY2sYEAzo1QKXBoN?=
 =?us-ascii?Q?zhsDQMPfyUQ1O34VteuAYFhgRbpQ5mIlJvXQFv8oArPDO11NwsN5rDMIayG+?=
 =?us-ascii?Q?Tsqje4VmZIRiQBtDiQQh8psJp6dJLxA//uG78qbxA/lpRpk/LOz+OEOsj5l9?=
 =?us-ascii?Q?qIuKIuce5eg2rTI5V1O/b9VfZR/Tu5QghnwHUhwh5uZ3LEuzNtrHuobT/g36?=
 =?us-ascii?Q?8FQMNJfd1hGHsVzrMFiudEg48lC86QfWnsGXJl/7SH5gMsA2vRQtHI/rA5dR?=
 =?us-ascii?Q?X0735O89DDP34MYBF5gBYKllCXHpFc/fYICOi8mHylonMyHP0iwfm9zCMBlB?=
 =?us-ascii?Q?KL3PxO0trLwl54r7SmnK0N59OtbbSDtQoW/y3JnhHmCaZVkC8cifTuwAEzn0?=
 =?us-ascii?Q?dETpdVTf9zVGrUMnKgoDqVXyoo1dpk+LaVm2d359yxwN93/HY/y3b/TQnwGe?=
 =?us-ascii?Q?qccUyIk0rwEY4AjSUbJ66NjVG8sQnL9PWVkD5NgJN9M11gxnuIt+MlgGXXR7?=
 =?us-ascii?Q?MklE2MjzafIVBJUEXQLpTqTri/9XiK7581HDTBHY+xUx5uo9hFlVvw23dNLD?=
 =?us-ascii?Q?2hfM6P/fDSmU//1n2KdTJVDrhNtANTaxUkIwJSj9IHlvDyqE5++nziaiPcd/?=
 =?us-ascii?Q?OIHimyklim3hAo8ijSUL0/M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(19092799006)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+m2h6zfP8u7yrTIUxtUzgmOD9xV80kZi0KjlLg/B4zj0T8+vn3EXT6Oukp1j?=
 =?us-ascii?Q?F3lYtjR+asiM6F3jbQ5hkSd2/Cih/QJGZw2EcnVcjhhjxME1rzrTKMJSp8M1?=
 =?us-ascii?Q?lvMBNQ1Cf0/csLWtm/rZWBJuMA186nMzCCRgsxr4XuCN8NV9eTse5nRdS/On?=
 =?us-ascii?Q?M0CKRrnAYHTNWSRCzcZ9v1dV/LGv7TvBEFLKa5M3B5SdIY+5VM0JHh+nyjSe?=
 =?us-ascii?Q?BAkQZBnCt88qB34D9Lt6RmzgfbRGlIg8jAO8qAtWv3pvAWDqJYvqcCQwWgUC?=
 =?us-ascii?Q?hFhzBq6aulq8lSexMrdlO/AZrt2twjROJiMyVy1u0j+ERF2CUeODSM/bfgK+?=
 =?us-ascii?Q?RDW/V0fGOMF22zKzBXSP1LEHMsFGdrmRffGiE7AP0SupQg3vM5Rp8/Sy153X?=
 =?us-ascii?Q?nQiQH1owY1hpoGRJZCY0f7kk0APqhmy+eXl7KPO3BUtpyC+nhnW3dML6j52c?=
 =?us-ascii?Q?ZlIcvXyziSVBet2nqn5EYWHz7YGWB54hxuFz6xkMA+cpP4DLhH8tuWzrzrGe?=
 =?us-ascii?Q?u+QWW0hteGZXeT79YZZYs4xsm9ixunB2TA5o7S7rgZPCNGubNgBUztsAmjDl?=
 =?us-ascii?Q?yuHtkJYyhcyv9n1HQmRkXVUGUPi+Y49K1BWGXCnG23WiiecnUzDR2FzkYFJk?=
 =?us-ascii?Q?XdKFwg30P7ZWNT8kLzeEjY8uptuMK1Z05ZTImXYchjqFTiEMKJ0QZKDR/l7R?=
 =?us-ascii?Q?seT0wfRx7qT1iAH7hLEQa+nUrTLaU6MihH2PVWLi8MBchBbkW3An9cgnn/jq?=
 =?us-ascii?Q?sFsbny9nuDpxdBjZvK/dYbTkUr2PyiG/iCtKI0iUYAUXUC97/MTeAHBfHF9m?=
 =?us-ascii?Q?fuzLaTSViNmysRks3pTG1p1RWnHPjOPgyhA3pfgme1iWT216XgXJjOhpdv4w?=
 =?us-ascii?Q?wMBfpMMsgni9j8GN2tB5A2i6u+5p5mISg2lYNFRahPwiKc4wzP5TlEHDZvKd?=
 =?us-ascii?Q?z0BpsrzEkItHngOI3QYG3d2mHLFNaotAhmmG93F6SrZ7gZyhoYJ5kfofZDag?=
 =?us-ascii?Q?oIGahRXI1Wy/d3LClCU2p0SBhqb+CRBG2duijbsv0tOUX7/hI+oK6bfMWlzF?=
 =?us-ascii?Q?CpKbJlLhBc0hF9mZrtjJrbaVHvfuZwq/IvT/trxHAgXd316mQbZeEDLKpLPB?=
 =?us-ascii?Q?rPYVncPum85N1ROadT0jpYkzNQfjxb9kIk/77prljnYwuYfxE7NufFm0U2sG?=
 =?us-ascii?Q?Sf4cqKzk7O7CSK9oXciH0uBL4UlmCwwLuInHnFuS0EaLqwQfsonL6cpYrtHI?=
 =?us-ascii?Q?1FeAZJR51aV01P7xlw9IlH+bG872oTFiQxcGDpgjfzNxY86IrUO4a4vDlauW?=
 =?us-ascii?Q?L3EgWDiDvcDOSMLINyZ8Woi93E/fS2VkV5aA6EVqFeTzi7CIxAZ4S5oRclJ8?=
 =?us-ascii?Q?nfBVXToeb5LVSL7GbZ76VQAO+hXyRA10k550uvt2Emf840hQm7Liv/fWMQDS?=
 =?us-ascii?Q?roj6Ws3DLykobIdLSklYa+/LwdG0hSQEg7auwiiQb0LqQwKAFv/CJl/pelzu?=
 =?us-ascii?Q?yuYREFQtwAeMEXoSniGqJWlHy0Fu2f1jD+PjM8nK8BBCtHrk9Nn3K5ggxw2p?=
 =?us-ascii?Q?kAEMdjQxZTvGsAk7Z0TpfQIxwSJQTq+h04NkPJSVsgllrF3DTz5E8jmOjNP7?=
 =?us-ascii?Q?G3DoQTbYVC8kuTGs35AICeIlMR7VI6/sQ0EF77GAb07Q0xTnWrn9ZQamPwdW?=
 =?us-ascii?Q?ugTWWb69kuL0PqpGQmBayocEnUpKIySoCf+1T3GBtd6/Vi44?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e213c1b-eb9d-4dbe-efdd-08de60f3a583
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2026 18:07:50.5207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w2VHHI4rcmilWuILn/abBILUz7g8vQmJesldKweO162RVqhegGxwIbAk5hGt+nirtI9xV4+6MZ8wn3M6Q9ns0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7189
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8636-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CEE60C37B1
X-Rspamd-Action: no action

On Sat, Jan 31, 2026 at 06:45:50PM +0800, Shi-Shenghui wrote:
> From: Shenghui Shi <brody.shi@m2semi.com>
>
> When using MSI (not MSI-X) with multiple IRQs, the MSI data value
> must be unique per vector to ensure correct interrupt delivery.
> Currently, the driver fails to increment the MSI data per vector,
> causing interrupts to be misrouted.
>
> Fix this by caching the base MSI data and adjusting each vector's
> data accordingly during IRQ setup.
>
> This issue was reproduced and tested on:
> - Device: [20e0:2502] (rev 01)
> - Kernel: 6.8.0-90-generic

I think needn't these informaiton, fixes tag commit already know which
kernel have problem.

>
> Fixes: e63d79d1ff04 ("dmaengine: dw-edma: Add Synopsys DesignWare eDMA IP core driver")
>
> Signed-off-by: Shenghui Shi <brody.shi@m2semi.com>
> ---
>  drivers/dma/dw-edma/dw-edma-core.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index 8e5f7defa6b6..2b2a59fec053 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -844,11 +844,13 @@ static int dw_edma_irq_request(struct dw_edma *dw,
>  {
>  	struct dw_edma_chip *chip = dw->chip;
>  	struct device *dev = dw->chip->dev;
> +	struct msi_desc *msi_desc;
>  	u32 wr_mask = 1;
>  	u32 rd_mask = 1;
>  	int i, err = 0;
>  	u32 ch_cnt;
>  	int irq;
> +	bool is_msix = false;

needn't set false.


>
>  	ch_cnt = dw->wr_ch_cnt + dw->rd_ch_cnt;
>
> @@ -895,9 +897,13 @@ static int dw_edma_irq_request(struct dw_edma *dw,
>  					  &dw->irq[i]);
>  			if (err)
>  				goto err_irq_free;
> -
> -			if (irq_get_msi_desc(irq))
> +			msi_desc = irq_get_msi_desc(irq);
> +			if (msi_desc) {

I prefer declear is_msix here and use "is_msi" insteand is_msix

				bool is_msi;

>  				get_cached_msi_msg(irq, &dw->irq[i].msi);
> +				is_msix = msi_desc && msi_desc->pci.msi_attrib.is_msix;
> +				if (!is_msix && i > 0)

needn't check i > 0

do nothing  "dw->irq[0].msi.data = dw->irq[0].msi.data + 0"

Frank
> +					dw->irq[i].msi.data = dw->irq[0].msi.data + i;
> +			}
>  		}
>
>  		dw->nr_irqs = i;
> --
> 2.49.0.windows.1
>

