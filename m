Return-Path: <dmaengine+bounces-8803-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEPTNvdAhmmbLQQAu9opvQ
	(envelope-from <dmaengine+bounces-8803-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 20:28:55 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8894E102BE6
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 20:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 248413004228
	for <lists+dmaengine@lfdr.de>; Fri,  6 Feb 2026 19:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427093093A7;
	Fri,  6 Feb 2026 19:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LsS8s50s"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013060.outbound.protection.outlook.com [40.107.159.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45C4302CBA;
	Fri,  6 Feb 2026 19:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770405882; cv=fail; b=DvN1KzMxZyDQYaejq7k3o2awMT5ApEzN1RsqY70hltKhbRD3DmzfJsue3Zf/vRxZvcw4hXgBiASxfPfCctl4uUnl+bi0nPq1VxNKXw5hUW2jSKwCZQ5+Wm22RvXSsl0HCEEp40BNW3rJsP2demBFUn3eMW7PmDImftRIxQJl8fc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770405882; c=relaxed/simple;
	bh=sbHs4uQ3q1K/Qocrc9vtjA6ZoeeCxXHPcHpDuXPs9Ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ruUBfDmG3cxodMkovg6pRUSVitc0a+XBJ/QmdZ01kM0ceIssNgvLA9IrgpUhC8xyQtnFL5IL2yZj0JxprGCG4GrYJvIC1Xr/kq90rShUKXBl18q7x3MV4pDyEgsgZbemosC/EmoOs2hiznPz/Ad9hl3P8nRDlGJ3gKTSvkzFS3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LsS8s50s; arc=fail smtp.client-ip=40.107.159.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MQd7uWfqP2GweoelBCUSesYT6bYgHkzehDCog7ZbcYoUToGjwb9yW11fHXtcw4NVpQjBKTE0wE8qo8E9VWuPUfcz4kbHhjaQvAzgf4rf/b+TFriZlh/CjbnaqAv/aJmoIveHEQDFvSnvYf8Z6zB000NUam6mbGkFBxT6DwWNd/8kLu3KnhzaopwIj0L/3YydWYmLLZ85wTjHOGjU47poIfFFatuq20r9e6IDSxhkuwHuMHDxvqJts8s69eayxiz9ujUoIaIVq66aCM8ciKb7ejsckK2GJl1vpu6lm59gb3XLoVgdHwT3ldJ9TEASdEQk5rFcEecbamiyGZ8UHaP1eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1EvuhBNQK6DTDG1Le8Xam3LIRzr1H4LhR5FGvoX4GGU=;
 b=Csxee6t3eiflUC95Q2kW1lcJepywbdptmYan0YqPD/ZFe/CbFdhJ5CvUlilGZRicAEyxV2q9giKdqePcVef4hOazcDOwxOHq0ra4V3clkEjL85RL7AuTUzZZONzpy3/htY/d4u5MDdPklwWzZUwW4JtOcrbMYuF/hevgabSFcC59961xaYXX+QztJ0SXd2wxc+0ciz9hsYxjmMrMW4XRthqMKwgNmCP+Zyx4LxJfQWFn7Vc4Fxxk/wdvvulwlhi/Ou7mO5+OdK2cZZLw4hgF9VzNl9v1UdUxqAQLR5QFBWZlF8hWOVnyoFfl293dZNGgQR3vWrMu0gYfqNLv2isWuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1EvuhBNQK6DTDG1Le8Xam3LIRzr1H4LhR5FGvoX4GGU=;
 b=LsS8s50sNChUweEHvZqJZIsSpdn+jbJ4of/a4GYGuSYhgSxUMX3C22bG6V9jDMJDpOdEFACQH4FycnO75OcmEcFE2bUI9hF2gxGCPoMyX3sUbdVRh+FFgk3EIW5ZjzlqZqDDfqCCiYBjGVdm31w7F22w+s9pylJuxxo/JBu1wR2MSSleeKYP0F3cVd2kUVVTTtAwIdXs1QPmlOF9VxZkAyShKDEeY142YOcnrkISsPElIfWOBTxlX0NNi7m02cDTpDQHITQsSN2ZeFhwWXrYZIJ8JJ72cb2aRCwk3xlnkZglf+IJM0Sco8rPjVvNOl0hSa+y9pvdrKAPuBhdYJ10qA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DU4PR04MB10402.eurprd04.prod.outlook.com (2603:10a6:10:55b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Fri, 6 Feb
 2026 19:24:39 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9587.010; Fri, 6 Feb 2026
 19:24:39 +0000
Date: Fri, 6 Feb 2026 14:24:31 -0500
From: Frank Li <Frank.li@nxp.com>
To: Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, vkoul@kernel.org,
	Frank.Li@kernel.org, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org, quic_varada@quicinc.com
Subject: Re: [PATCH v4 1/7] dma: qcom: bam_dma: Fix command element mask
 field for BAM v1.6.0+
Message-ID: <aYY_72kT63lH1h2r@lizhi-Precision-Tower-5810>
References: <20260206100202.413834-1-quic_mdalam@quicinc.com>
 <20260206100202.413834-2-quic_mdalam@quicinc.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206100202.413834-2-quic_mdalam@quicinc.com>
X-ClientProxiedBy: PH1PEPF000132ED.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:518:1::32) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DU4PR04MB10402:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f0d43f3-767e-4365-4ba2-08de65b55ee2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|19092799006|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?91oKj6M0v5tMeRLQzDKuAHICWmVV+ZNwQ+RCYR6Wc9zItfeEcywNrXX6akfM?=
 =?us-ascii?Q?b9dbAit3FqTq7k9iKJcEO0Gc0PMAGPJ5D6Yc3nv0IAbLndVmQ9eg9FMzXJoV?=
 =?us-ascii?Q?MZESW4aqSvy6FrXQch3Io8NsLlIojcXSOyNKx2Lhq2mppPHdFlhEIDs1GtjV?=
 =?us-ascii?Q?TUE/DW0XSegMI9WRVmKyFCfy8hIOKIePkIR4IkVRFmdjYy4/4d0bNe6bQycK?=
 =?us-ascii?Q?4zhzLkLWmW8h1NfKnXC1ehGAyTe/7mouJzT0wfGri9O/ZFbu1cUfWEGxRhfJ?=
 =?us-ascii?Q?zhlD2dyq1xsVtqZpJe7CSk37nPW2QgLaXsQr7Rtj04st8SSgNZMCy0nBJ/9S?=
 =?us-ascii?Q?8s3TTAzMiwTrGp/vwT5Zfw303A8KPSyJY3Y5rgWII2fnIWQfPzriTvVQA3Jx?=
 =?us-ascii?Q?p0znMmdIz8EBXx25oG0aAgP/Sx1aP8vvTjIc1wbpym8FA2xI5EEZahH85u9y?=
 =?us-ascii?Q?/R74kV4OU3QK0PIPnEIrb/u979Txh/L3yd77X0h7gBv7HTOkuMrnVuDFum4s?=
 =?us-ascii?Q?5VWKMepHpIIJuROgAxh8xDBj0D6JVVmhx8yoJ4pR6Q7oj3BxmIbSVWdjKe8c?=
 =?us-ascii?Q?LDv+p4OXGTHpHkOpWkIwHV9e5t9jLQ9WXsBbcAOAG5MoJF7JkllTe0Nrl+N9?=
 =?us-ascii?Q?ZaxtVmIfr4IJ0q58i3eV0dTOzCKqPsgzXWXepR901u87adhrBMRiPjoKZ4ym?=
 =?us-ascii?Q?64X9Ha40l2UrHf3aCNekHZX+w9zz4pFZjF+1QHfA2r5lqIkLPHER85bgYkZy?=
 =?us-ascii?Q?aG3oGot1rZ6wjQ21agxwxBgi7M0Y0gewkr6pO0y8sivmkSHwJuaHu9zAxSPC?=
 =?us-ascii?Q?2BDqtE8Rdc8+S9hKxLqGWw+0iJyDiKFg0DyD/tdQiNfuMUZdfV5Pv/Z1qKO2?=
 =?us-ascii?Q?mFPZmy6Jv3hNNj3TK7gn4que1eil+73cY7FfI9fiy0pq3Dq+xKu82fHtzFn8?=
 =?us-ascii?Q?8UKPjpJ6czqoNp6CYK3M3nnG8Y2lB9l3ZEiyTyjBBLvWduv0kGDSHMMb0XXW?=
 =?us-ascii?Q?gD/hAYz5na69AcNQKkVEbkyVZguJ6KCeOQZMrH0/KhFuYBglXzsx3RHQmKMb?=
 =?us-ascii?Q?jN7YVX57ngjNuUlV55YBU7R7b6FSOrGu6ISSM4RYm69kAxVZk5VbF1+1qweE?=
 =?us-ascii?Q?fhAov0ffi2widnNgEaGtcoLZaOxnlcBIlr/eOI+bGYxUtWiuvN1yqW8xU8WB?=
 =?us-ascii?Q?DwLxTgiKrkPJ5EvzYfpRN3x/pb2zCJs9ubq8DJ57UWGHcg6cQrNoocF58EwE?=
 =?us-ascii?Q?17voe3f0MiSms21mHbXrRPT5jG3pzMxGrf5q7MXe2b3b8QmhtaFcs5Jl0Hch?=
 =?us-ascii?Q?gjUtjJaw2TDboO+0xdWQd4IXMSxJ+xbzQzkR+uBtDocPRNLgm7UlW+KC6R8E?=
 =?us-ascii?Q?/LPkEHN5qAj780NZVDW6LxXp3w8YGGXX2cWZPaF4bUQOTGCZHmxkTM0hCLjV?=
 =?us-ascii?Q?UlWTvFTfKYlUozuOpTvRssqM+3fT1BGIvKdnW/6oRAHdk41ax3Iw3GDGHBQI?=
 =?us-ascii?Q?3pB4H4+TRKLFLiDflM0b7IExlNlUNmjShja4QH8uWqi8veerkSg0PLhI53Io?=
 =?us-ascii?Q?VnIuhf2S/vtVLZrlgvmEM/V7Ur7AFPasssRiUxJjJW/EAGIhs6qbAtLZbzkK?=
 =?us-ascii?Q?btvn/IapTN/QdToF0TQbqEg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(19092799006)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o81GObGtU8QSnAbq24iOtgrDla5v8nvjYCgT9BZhA3HTsjXaLPulXWwVP6Ud?=
 =?us-ascii?Q?9FQ4KatA9NMEoFzvnVKrRRpaJJ/sgC76Mlw4Vf/miyibG2T2s0QgUm6q7Jnc?=
 =?us-ascii?Q?zBRyiB02NFi/fnuurisM/M1rH0PsoDPfXHplrbnmZ4BoNthK8WhXE19/s4jj?=
 =?us-ascii?Q?4EbZlZo1rN115AWg/QkaUg85ZJbURhMS9k/j77s+l5Yop+5trrC7BnKhww9R?=
 =?us-ascii?Q?QaTY8EZSXXOPyfj3ASqUBG/kp69ASE3N+tHM69ZJ5Io2jV5Vlj3drm3p/k7y?=
 =?us-ascii?Q?QYic5DJrQsW1K1FJfRrsnAxhw+lOD3OjXO5y2CjKIpuH1WYK3F4Ggryudsq1?=
 =?us-ascii?Q?6YjsfDlLtNXsA9hP3WsaEZRJAbYp7hKlvGyNsWeW/2oCYB09U1BoxKwxXs5R?=
 =?us-ascii?Q?nQrb+xflxMfBvXBAKmJH8UdOMFuKPpnmphsFltgpoC0jCMQVwM77bZc3eh97?=
 =?us-ascii?Q?qIx1FnmSMI99HCpUjldWRJNB3Www2NnNEGf/uv9dDtpIJgOGC/EM+vjI6hyd?=
 =?us-ascii?Q?1LtWg57zBvy0dAq3ScqIsRDxFOPa8JGlXR7yhaLqgbAD9bxQyGE+c7eyZGAs?=
 =?us-ascii?Q?cgh8QEM+G1UXoxyTUP+BTu0ZydD2AW+YD6et0Ja8LltYtvzqhXXAXh2AbeQW?=
 =?us-ascii?Q?TewEZYM57J02kiLJ1vihGloNKXSSUpM2APRFZz71A4u1QttGpGCWEbBs8oBg?=
 =?us-ascii?Q?zf6zKmF+Nq55Cu4gpkQW1E7DgOYPFL0hDarxQhCRHmEYOLTZ1KczKp6vdTBY?=
 =?us-ascii?Q?LlNtLykRK7C3L6Dhew03wJly4IM+R1XUxwRqBJ1yVQ/x8OMZMJYEJAj9pc6L?=
 =?us-ascii?Q?pWJXa/CzjYyN2ZWKNnMXCNrI081P8LKcrwLCAAYWVaM/CzTlwkn0Xg7+itRh?=
 =?us-ascii?Q?sIq6XPCbQ9jbSDSbaRwMDZVzRdyn8W7MoMra/nZXy+DiF6Hy47j14mgpJemd?=
 =?us-ascii?Q?58bBW3rEwyUVHQHOG/WMY68mvvzPdJcu5+W0WODeba6guxT5kCKJ/TDYUN1b?=
 =?us-ascii?Q?Sq91VPD4wMmAZRtmn5x3a5hC6RKJUrUEHruUkEpfRbYkM5i3wimRu+LhbzhL?=
 =?us-ascii?Q?8RfD1vWww4e3LdpKCALYAJ7C4+tNumz/KgEWB6zHSGkLsgj+kvQURErt2z56?=
 =?us-ascii?Q?pUSAFiE6JNYpORh52CBDJ2HknRi49LQfb504DrLFxJ5H+W2IM4V4q+Tbmpc5?=
 =?us-ascii?Q?VU7fopsZosFK2HEUi148mRkwsQCXR69BA5m77wjpkBK9iQ3mOBFDkxwBFiYf?=
 =?us-ascii?Q?LOHCQi2hbatjKU2XKb46V6GXUuKSB6Chct+NMR1aiDjTXerO5GHI7DxdCst3?=
 =?us-ascii?Q?x3W1BFWsELjBcwh1/YDky91SErpKbgqik84CKGkgHk+YrOYaOo4+SoBXUBkk?=
 =?us-ascii?Q?XpBjQCF/t2BNgUmbOw5lTQIYI//79VjEpmtRq/xJh0l6HoQT/yjj1rRxab1Z?=
 =?us-ascii?Q?HItchuxpmi43mNx8fGZUttc5xFz1or6X6H4LFcR3XagZHc90IBFvqufecQHp?=
 =?us-ascii?Q?6T41DS405xDiKi2c2G4eJOGS1q3bzoMv3mDruOOTSruiyyRT4M/S56ozQFkx?=
 =?us-ascii?Q?3k6nmWNpCDiOMpwykv7ISxVdlwZnYJQrEjKGISYYMMOAOmLo284/nzSCzzbm?=
 =?us-ascii?Q?j7AcTLt0aIIbYFwlMacs6lns8VS/pP9Oxe0Tv3xaKjOKuTAespK690TUwsyQ?=
 =?us-ascii?Q?XNqDuVjq51osOnDWKrzrCJw/0ST9B3p0w6DBMSJK8q5zRt5c?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f0d43f3-767e-4365-4ba2-08de65b55ee2
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 19:24:39.0246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NgqBMppN0F6gz3XAg8zUXk7dLNhKY5McYegIs+XsopgNgw4YrB8JEn5BoQIIoZnWDY4p1LDPw5WG/zHEx9MlIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10402
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
	TAGGED_FROM(0.00)[bounces-8803-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-0.956];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8894E102BE6
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 03:31:56PM +0530, Md Sadre Alam wrote:
> BAM version 1.6.0 and later changed the behavior of the mask field in
> command elements for read operations. In newer BAM versions, the mask
> field for read commands contains the upper 4 bits of the destination
> address to support 36-bit addressing, while for write commands it
> continues to function as a traditional write mask.
>
> This change causes NAND enumeration failures on platforms like IPQ5424
> that use BAM v1.6.0+, because the current code sets mask=0xffffffff
> for all commands. For read commands on newer BAM versions, this results
> in the hardware interpreting the destination address as 0xf_xxxxxxxx
> (invalid high memory) instead of the intended 0x0_xxxxxxxx address.
>
> Fixed this issue by:
> 1. Updating the bam_cmd_element structure documentation to reflect the
>    dual purpose of the mask field
> 2. Modifying bam_prep_ce_le32() to set appropriate mask values based on
>    command type:
>    - For read commands: mask = 0 (32-bit addressing, upper bits = 0)
>    - For write commands: mask = 0xffffffff (traditional write mask)
> 3. Maintaining backward compatibility with older BAM versions
>
> This fix enables proper NAND functionality on IPQ5424 and other platforms
> using BAM v1.6.0+ while preserving compatibility with existing systems.
>
> Tested-by: Lakshmi Sowjanya D <quic_laksd@quicinc.com>
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---
>
> Change in [v4]

Reviewed-by: Frank Li <Frank.Li@nxp.com>
>
> * No change
>
> Change in [v3]
>
> * Added Tested-by tag
>
> Change in [v2]
>
> * No change
>
> Change in [v1]
>
> * Updated bam_prep_ce_le32() to set the mask field conditionally based on
>   command type
>
> * Enhanced kernel-doc comments to clarify mask behavior for BAM v1.6.0+
>
>  include/linux/dma/qcom_bam_dma.h | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/dma/qcom_bam_dma.h b/include/linux/dma/qcom_bam_dma.h
> index 68fc0e643b1b..d9d07a9ab313 100644
> --- a/include/linux/dma/qcom_bam_dma.h
> +++ b/include/linux/dma/qcom_bam_dma.h
> @@ -13,9 +13,12 @@
>   * supported by BAM DMA Engine.
>   *
>   * @cmd_and_addr - upper 8 bits command and lower 24 bits register address.
> - * @data - for write command: content to be written into peripheral register.
> - *	   for read command: dest addr to write peripheral register value.
> - * @mask - register mask.
> + * @data - For write command: content to be written into peripheral register.
> + *	   For read command: lower 32 bits of destination address.
> + * @mask - For write command: register write mask.
> + *	   For read command on BAM v1.6.0+: upper 4 bits of destination address.
> + *	   For read command on BAM < v1.6.0: ignored by hardware.
> + *	   Setting to 0 ensures 32-bit addressing compatibility.
>   * @reserved - for future usage.
>   *
>   */
> @@ -42,6 +45,10 @@ enum bam_command_type {
>   * @addr: target address
>   * @cmd: BAM command
>   * @data: actual data for write and dest addr for read in le32
> + *
> + * For BAM v1.6.0+, the mask field behavior depends on command type:
> + * - Write commands: mask = write mask (typically 0xffffffff)
> + * - Read commands: mask = upper 4 bits of destination address (0 for 32-bit)
>   */
>  static inline void
>  bam_prep_ce_le32(struct bam_cmd_element *bam_ce, u32 addr,
> @@ -50,7 +57,11 @@ bam_prep_ce_le32(struct bam_cmd_element *bam_ce, u32 addr,
>  	bam_ce->cmd_and_addr =
>  		cpu_to_le32((addr & 0xffffff) | ((cmd & 0xff) << 24));
>  	bam_ce->data = data;
> -	bam_ce->mask = cpu_to_le32(0xffffffff);
> +	if (cmd == BAM_READ_COMMAND)
> +		bam_ce->mask = cpu_to_le32(0x0); /* 32-bit addressing */
> +	else
> +		bam_ce->mask = cpu_to_le32(0xffffffff); /* Write mask */
> +	bam_ce->reserved = 0;
>  }
>
>  /*
> @@ -60,7 +71,7 @@ bam_prep_ce_le32(struct bam_cmd_element *bam_ce, u32 addr,
>   * @bam_ce: BAM command element
>   * @addr: target address
>   * @cmd: BAM command
> - * @data: actual data for write and dest addr for read
> + * @data: actual data for write and destination address for read
>   */
>  static inline void
>  bam_prep_ce(struct bam_cmd_element *bam_ce, u32 addr,
> --
> 2.34.1
>

