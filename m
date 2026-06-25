Return-Path: <dmaengine+bounces-11786-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bQ9tGbBGPWqh0ggAu9opvQ
	(envelope-from <dmaengine+bounces-11786-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2026 17:18:08 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E13C6C6FEF
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2026 17:18:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=gTax+lUh;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11786-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11786-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73845303EC24
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2026 15:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77803E8343;
	Thu, 25 Jun 2026 15:16:44 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010014.outbound.protection.outlook.com [52.101.69.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3A031716D;
	Thu, 25 Jun 2026 15:16:42 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782400604; cv=fail; b=DVztB1aYq9mkB5DCeFS5AjvHonurTvlhi+b57EpBKoxCzkBB686ZImgO596LdhXuL+ZdS4c41vZ+u75BIry4w8ew3Vck/WjQcM0m7VvKBw/zx5wwFNxrP0piodz3i0U+vsRLecs0R9BBw4JxnTwyucfrC5RdocrTxTsFyVe6rcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782400604; c=relaxed/simple;
	bh=XBdAHRDsXtnEAlPfUeW4aR9GtIzvza2gtIdAIuJhkD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YVK4OU+7nPptUv7yDjWcGmmgoRptpgnwsLDA0ik1Msy3+HfuFSzU7LWVOSBCOx7oh9Ma1iyjgJUTXbwYr2olSsr2X7XWHgnTyK0BJQQJFsjwCNjBRswPaZuRTvFSpuaTbWFbh6JS7Q/KJolw5HJToiMy78SQSNNhGm1OGQ8sXbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=gTax+lUh; arc=fail smtp.client-ip=52.101.69.14
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wKMEg5K8Hk6tbAbAsbAcbSGoQHMrNYtU+i+bBIbMMW1q8nPuwlksgGIB8HnA7VKUEPjY5Me9NPSL/5M1DYvu7QkSp2jxSNhv504AWvEafgwOq3SwRjQ07Y1p+p2zT+1y6KJqcbNfLr0qBVXygIQcUIbx4xkNjpUYeKMxq0oKsd4UcSXyUoDr4VeXqgIW0vcvHeiWCqkHj9wHqgdRqlg7xga0T5QZytcExb8wltNqDyPFh5sK5eTiThv9P88BFwwxEniLSFjswQ/5n5WOXLPlIN9FTxNvVKn1vrUA7BnKk9WbuQSoe+02fXYLF0cI30lZjFd2y4NWp/iZ9VL8NxjiKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RWfD7yljXNkkuRRZBgW2+Lz3fQHA2gWCl8VfX2RoSls=;
 b=uAp8LzvokSF/HeKjy5mb3wqBKRQSm/jrMQT+mh1NYCOdO8xOCApu1XDXXAr9EeDvVCen5dW2qjcohiUvSHfOqjrIZaC/isB4LSL1zwZbzhJmF7yVnZpAMaFvv7E/JRn4hLYL27T2LMioOajtK3JKiqiDK6DLtFWNuoGt8JL2PiaMo7ctY5PM3Pyx3C8KhXrefiWPnaZZ8IUhU4Lz5bmBqLf1bAhGuM8U6x+wviGpp1mKI7Ufovs4cE0wb10PzSTJYlYmp1jKbE8LWSLEhKA4i0Ti0eWj52E2W1dCLpT7Ma9/FOVPkeSzt53/n6bFqCfpkOgN7qlw5/YKE5c/vVIHdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWfD7yljXNkkuRRZBgW2+Lz3fQHA2gWCl8VfX2RoSls=;
 b=gTax+lUhWTCJbKZMQSpzXs2AHeymqQzqiJvMkDWQOa/a7K1i/8f+fxDIc+1jyFAa06MUHrnbgMEUWIZ/uFhwt1tcoeqAtp75EjnMZmYpkG1Z/QDLl9CP5uZUB6GAXBkWssqxrynO4JV9dTXLC7JiDrppkH63k4YdixE5tu6j/2kFmNVBdZrXRdTBOe8bPeLnNowqlhUMTJVaTXC6+5taG6yT9S+qVqtv4UVQ6RJBPkDGItFCyP7Mip5szJ7Ugvhey8Y1nWzuDfI4CaPOQRuht3cHMuPTpA7S8L0SAK8B5k3WQBsDtYSYUee0BdlEdBg5TE46/D4h9mxYiQcoyGrJvg==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM7PR04MB6775.eurprd04.prod.outlook.com (2603:10a6:20b:102::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 15:16:40 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Thu, 25 Jun 2026
 15:16:40 +0000
Date: Thu, 25 Jun 2026 11:16:31 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Cc: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>,
	Angelo Dureghello <angelo@sysam.it>, Frank Li <Frank.Li@kernel.org>,
	imx@lists.linux.dev, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] dmaengine: fsl-edma: Add FSL_EDMA_DRV_MCF flag
 for ColdFire eDMA
Message-ID: <aj1GTwNQ9cHijfly@lizhi-Precision-Tower-5810>
References: <20260625-b4-edma-dmaengine-v3-0-44be00ace37d@yoseli.org>
 <20260625-b4-edma-dmaengine-v3-2-44be00ace37d@yoseli.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625-b4-edma-dmaengine-v3-2-44be00ace37d@yoseli.org>
X-ClientProxiedBy: PH8P221CA0012.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:2d8::17) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM7PR04MB6775:EE_
X-MS-Office365-Filtering-Correlation-Id: 87c184da-70ba-4621-3203-08ded2ccc0fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|19092799006|366016|23010399003|18002099003|22082099003|4143699003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	wgua4Us2n2DxjT0zPFjtzKZwvMQF8XDhBipt2+w0I4KPHZ49ucnGjkLdjDbsZZZFXd5nWiHv+4MXrXckRblE/gv/s4d/oUrNQ0eF8JonVl5TDKUAEymcWGwRBJY47qwBVFRriUQAbxoAbM4eXgKUpMS5Asx74y013184Lv6S0lB0awiVYKdkVRmOE1S8Hpd2siyQsQXTPEz7XuhSB1AZqOLLeDDzeoLGoLt96zgi4GfsuXzwVgwkaO6y1crKdIdGOyqt6RehT5ZEn9PpYBKXiUR6+FtvYbghwW5cFnQ+bU+/AXb3LDaZalZo6cM9AUbjzp0cSFIjmj/98aFChjYZlIIdGOEHP0cuZJtVfmIlseJYCFjgT/SiIeD/+OHVBRIatyitQwCgqcHtizH24dYEhJ0Vt23qgsKSoFElmUDsFO1JKToaEHElmuXEmLgqhHOG5lFrmSKTfg9S0K+aIsdhsCn5xogmrDQ1FmusBAVqYKbKewHNPXxo1cpy6B53OWJej9jwLBJXY+/fWeBUi2lTK8NjghLofhRSSNZSSMlWY53qi9hhY0zr82lT9UMFg2C2RUUs6q/Fr10bzcLejtdYh+aqgjrPBUfDVjLt+yD8UVzS1Uu1Usoxhgl1Y0k0dRNgUoY409oNefZ86NEIPUuAm8STuxIIOdLPbyM2skDTkok=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(19092799006)(366016)(23010399003)(18002099003)(22082099003)(4143699003)(11063799006)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zpRint08oGtOOo2xalh9DRYzbrN8EOpPkupEetcTc0kgDtgztxnyficpkEoj?=
 =?us-ascii?Q?ajZjl2Nh55PqnAjRrf1DFCf5x8cnOAAOBK+3sMIjbRBKWqZhGYRHUElgtlyo?=
 =?us-ascii?Q?YDZEBDwB3+3ACoMgucesh7UTObK3x50AD9etZKGCIP3gCHP3vgadSylhFrmW?=
 =?us-ascii?Q?9cJ4x3TwrUU+rcIqOlZL+HhkHW45GowXawr/vv+ooUR99U2sheWOzypK1sVZ?=
 =?us-ascii?Q?yZxHy3r6AXa0JpMBtSwvcYdIuxVsEVKQGluh74ua96DhRvN9N2q0hUIgQIVx?=
 =?us-ascii?Q?RnkYBNYcjkHuouAfINNzE63epapHBUXt3QhxFBOL04+SJOthl6ew+nDtEUH1?=
 =?us-ascii?Q?soqDQ58icwSiyS8A6FUXXkKW9Rh4ZfJd1RnmDFh4BAYeSVtLUSkK8EpPGhGn?=
 =?us-ascii?Q?mlVw+CLLVijqcPkuN4xqOSSJxZPwP0iT4NonX9oDVZ8PSqLb2ZWr8RtRAhZI?=
 =?us-ascii?Q?95WaZoQwaXOwOHLxGQsZBK9BmkhKkzsVHiXXV5wlZY877UfaVcShdkdeQE9I?=
 =?us-ascii?Q?aJRGX+4iJ3nMZ1Onr+1rz5mi4DCeGkrX6EutC+YMoBCJEzlGzfa3lWbGzaBr?=
 =?us-ascii?Q?DdQg3Nx9ptG6YHjx0oIOR2nMXTmuVxSaYNOXE4O7Myt80Wj8oBU2K7JFa0az?=
 =?us-ascii?Q?Tw14OqN3Nkp1o50mWieaWvv+c+UGHmXhXQU6ft8DF9P7oy+/IdaezTb6nWKv?=
 =?us-ascii?Q?36yVEzaX3Bgy4Y6bFGyWmzvbJiXG6g1Ov4RujMAEeFHpP40+PqQ2uq4XvO0h?=
 =?us-ascii?Q?zbNLican3uXLJlQrniG+aLY2kHK0KurvrC05c/5m+1KBZupG73Cd6tutlHFt?=
 =?us-ascii?Q?jbRlPWrZjppn7RjO9DkuDCPfbQIPhUpE06ugQ2xaYcDygGfdIN98+BUrkwwj?=
 =?us-ascii?Q?4UbgEK1apGXaKUaVFqVovYgMuR0VPthkGcz8PBkxVw7gASR3Edl5Mq/f/M/S?=
 =?us-ascii?Q?ubp4zyUKop+opKphnae1eI8XAbG5TWRMeAzLQnudAUDSLpdBvgQ9TyENpUIB?=
 =?us-ascii?Q?Pcc9W6o0A5j5frtEQKdnc1g95qCXk+1pdYVUW7JjDkSS6ddygZ7cIvem5y0j?=
 =?us-ascii?Q?wa3a3+bqU1aIdW3iKrRTSw25KZPdHEtpW98SWsh878lGk+vcHVFnCwiRiKDg?=
 =?us-ascii?Q?NLLc9upOFUx1yQ+cAr+L4TmkVMvPbxkjTFBEqHUeTzRIIJMNC/7TvLUZM7pO?=
 =?us-ascii?Q?NY8cskNDQRvhOi0YLNcMrpxY84s2nmPAMU+9+XhU/3qaHnLzPiWwPI+6MHSv?=
 =?us-ascii?Q?T0tOh+XnHLSlgK65y0Bxi2KFed9oT57WU1XqC4gKflFFuo36uk6Mh1yjBjpz?=
 =?us-ascii?Q?9Z3ps961SIlroUIw4ay+CR7Y8/zKtYpralgchrjo1faj3hYbMksiWClW07z1?=
 =?us-ascii?Q?yu4cQN9QChJ2b9xzjXrPbmRVrcrnLFm+X74ON4os1Qis6uOxWq8KHr3EdKbJ?=
 =?us-ascii?Q?zIM8oNesnJwOPe/AiHO3T3Uts1ONhz1NCwxiwe6lSTJR4fcIvaqOS4kapEAE?=
 =?us-ascii?Q?zyhzv8FpRRiuT81Uw/jAChDaZ4ZMsht4wM7Jnqxlx2uQZMQpfmKc85ntWpLn?=
 =?us-ascii?Q?STWZoZrz3cfmdMEJrBPT/jQ2SGkETKWM4ZS3Ix6o+w7N9eSdLYuNTUQAOx21?=
 =?us-ascii?Q?qcWa6kAAHlF80LmUJuqiCe0fMnqXc7tmFCVxYs5Qo/+Q7Apavler04BgsorM?=
 =?us-ascii?Q?O2s5V2ho8MYsOgytQrekzMxcH8JGQVMKmDS56vQ+cpkViscZi93YzT4gFjbB?=
 =?us-ascii?Q?EE+22M/GmzF/KbBirLp4eOznnUNhx+H0OPQuZj8IaidLMufGzr7/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87c184da-70ba-4621-3203-08ded2ccc0fe
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 15:16:38.9183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ozvKQ6/rZjDiNDMCJSIqnYQZT2WEc8FXHkkhnm+uBWWoz0XG/u05Yzsl/zNAwf/oC5z+KNcohf92D4seBLimDBG4cEFWEuMN8NoQdbzFWP6PjLiAU7clXQm3hW/dN35
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6775
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11786-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jeanmichel.hautbois@yoseli.org,m:Frank.Li@nxp.com,m:vkoul@kernel.org,m:angelo@sysam.it,m:Frank.Li@kernel.org,m:imx@lists.linux.dev,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,lizhi-Precision-Tower-5810:mid,NXP1.onmicrosoft.com:dkim,oss.nxp.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6E13C6C6FEF

On Thu, Jun 25, 2026 at 10:59:38AM +0200, Jean-Michel Hautbois wrote:
> Add FSL_EDMA_DRV_MCF driver flag to identify MCF ColdFire eDMA
> controllers which have a native M68K register layout.
>
> The edma_writeb() function applies an XOR ^ 0x3 byte-lane adjustment for
> big-endian eDMA controllers where byte registers within a 32-bit word
> need address correction due to endianness differences between the CPU
> and hardware IP block.
>
> However, the MCF54418 eDMA is native to the ColdFire architecture and
> its 8-bit registers (SERQ, CERQ, SEEI, CEEI, CINT, CERR, SSRT, CDNE) are
> located at sequential byte addresses (0x4018-0x401F) as documented in
> the MCF54418 Reference Manual Table 19-2. No byte-lane adjustment is
> needed - applying the XOR causes writes to target incorrect registers
> (e.g., writing to CERR at 0x401D would actually access SSRT at 0x401E).
>
> Set this flag in the MCF eDMA driver to bypass the XOR adjustment and
> access registers at their documented addresses.
>
> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
> ---
>  drivers/dma/fsl-edma-common.h | 5 ++++-
>  drivers/dma/mcf-edma-main.c   | 2 +-
>  2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
> index abc8f7805515..64b537527291 100644
> --- a/drivers/dma/fsl-edma-common.h
> +++ b/drivers/dma/fsl-edma-common.h
> @@ -225,6 +225,8 @@ struct fsl_edma_desc {
>  #define FSL_EDMA_DRV_TCD64		BIT(15)
>  /* All channel ERR IRQ share one IRQ line */
>  #define FSL_EDMA_DRV_ERRIRQ_SHARE       BIT(16)
> +/* MCF eDMA: Different register layout, no XOR for byte access */
> +#define FSL_EDMA_DRV_MCF                BIT(17)
>
>
>  #define FSL_EDMA_DRV_EDMA3	(FSL_EDMA_DRV_SPLIT_REG |	\
> @@ -419,7 +421,8 @@ static inline void edma_writeb(struct fsl_edma_engine *edma,
>  			       u8 val, void __iomem *addr)
>  {
>  	/* swap the reg offset for these in big-endian mode */
> -	if (edma->big_endian)

I think native endian, needn't set big_endian. Does it work if don't
set big_endian for MCF54418?

Frank

> +	/* MCF eDMA has different register layout, no XOR needed */
> +	if (edma->big_endian && !(edma->drvdata->flags & FSL_EDMA_DRV_MCF))
>  		iowrite8(val, (void __iomem *)((unsigned long)addr ^ 0x3));
>  	else
>  		iowrite8(val, addr);
> diff --git a/drivers/dma/mcf-edma-main.c b/drivers/dma/mcf-edma-main.c
> index 9e1c6400c77b..f95114829d80 100644
> --- a/drivers/dma/mcf-edma-main.c
> +++ b/drivers/dma/mcf-edma-main.c
> @@ -145,7 +145,7 @@ static void mcf_edma_irq_free(struct platform_device *pdev,
>  }
>
>  static struct fsl_edma_drvdata mcf_data = {
> -	.flags = FSL_EDMA_DRV_EDMA64,
> +	.flags = FSL_EDMA_DRV_EDMA64 | FSL_EDMA_DRV_MCF,
>  	.setup_irq = mcf_edma_irq_init,
>  };
>
>
> --
> 2.39.5
>

