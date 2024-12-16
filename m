Return-Path: <dmaengine+bounces-3989-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FB49F35C7
	for <lists+dmaengine@lfdr.de>; Mon, 16 Dec 2024 17:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82B1C188B69B
	for <lists+dmaengine@lfdr.de>; Mon, 16 Dec 2024 16:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D01E2063DB;
	Mon, 16 Dec 2024 16:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lbvp/cdZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012041.outbound.protection.outlook.com [52.101.66.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0849D200A0;
	Mon, 16 Dec 2024 16:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734365866; cv=fail; b=EKvNKyJyG3vOi+YkX4QQDVhyjOLQ4yLPBKsjGY1WdWmI+LKrHAI5YQ7ZPHUjguS02PAHm1FdbJxDRlOcAiMRbCPiUjXButNLeUfrDaiUDERg2fhaeMHrAeu/R8e4s/kGGK9dU6ArXyo6IRIEtrF6zUKZjOMaPwfndm/XyTD4VbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734365866; c=relaxed/simple;
	bh=34i4TtuIP/ttgJpATdZjF1DOBoomIHeL7AXvHti8kKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MfsbNw0qEk91+gr9DCBNW9zZoi5edmHv1//+CfdEcKi8KFbRN2b8p0yrtIOJwfBO1fvRZGaUBP2mKyq9oq6tVooUkB3u1F+TGwxalZYEHQmNuAiPW+GiMeBYXeaw6LGenKfuy3epkPMgHqqsckCwP5/0j398MUigbsG3V+VqOgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lbvp/cdZ; arc=fail smtp.client-ip=52.101.66.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qjCSgEADF/MeaVRSQHPTO9yuFXnRVnOrtfNffV6WRNxEWRR2XJSG+zN/59vwm3iLSM6Q35lDBOV8iUmXhruDKSUQKNGWxKZOU8zGNfgeHGVvXI51kM1CTaQqJBTvX1Ql9uDOs4q/NjuZNreiNC1KQp0OUph4VREYtKqVeTYMRqhw5gO0Q+Mc6V4zidXow597KyRZq4W7g62b5fu3xzkFF39/4nZknZkt1gzubzKELbriuIFI5QHzNTKbKGnsGZuhw0h9FpvjIqt2cI4VzJ+TqXTMCUkKJpnIJPHS7c4q3ri0csFa8CjT80ln4gekAr6gBfiklExw9yc8Z24b9NNZlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AgoTpVTJTES2D/iCrn72FNRle2WT6CKQ8Y7Y1FaNV5g=;
 b=O+tVXMbpmesfURUU8qab53T6JzHomabxBks60D6UjDDV33q9TP7aG8IfeTu6HLitW3lVi9z651FQAlmQGk6MNqrcIDv3+JYk8YGhnEcXLO4iZl7353OUynPp5QVkkNjjkY99LZFcFXZpO6b4Lbn4xXXfBknJTyla7fPvZ1AK+93d/MEX2HkTFJ+w6Lzb1OKYu9bt9/d4JyPL6OqIsEfOyEIpXoTeELGawgZfIgt7wzgX4W9SMnSepw8lTEDT5LB31uNbAZDBw88mPK77lfY3lXYwmgk7k5Lx8wiwSMNlR9DXKhW5UnbTKvQbqa887+rh2qCj5fjsrdYS70877uu8Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AgoTpVTJTES2D/iCrn72FNRle2WT6CKQ8Y7Y1FaNV5g=;
 b=lbvp/cdZt8+yBfcYigDHc1SuP3ViamnFIphGd0NvGf/ngjBePtuYFV5whKs+GgszHf3aEax3oMh3YkALCin+dSB13+uOPKAqaGbYfM7UEUrearf1l5yL5HXITvuWoLCm/aD1pTIdPkeh7/vbbVmnjMbmSiNhUHvstpweQhbat7WEFCwcWh2NpYkLd47sbgkLc3Ir9AusrA0ccvusLMJ7bTOx34FBB/g9cHIlOcoP8gT/Ky2odrwzLFOOUJ9AItTS4UlT8o3KV8Q8xnYbfpYUeZKHYvzpwEeIrAN0Zg1hhxARqHgBEILmwuH6wna5geaFJhUbOC02WI1sSr4Lgj17Xg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8529.eurprd04.prod.outlook.com (2603:10a6:20b:420::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 16:17:41 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8251.008; Mon, 16 Dec 2024
 16:17:41 +0000
Date: Mon, 16 Dec 2024 11:17:35 -0500
From: Frank Li <Frank.li@nxp.com>
To: Larisa Grigore <larisa.grigore@oss.nxp.com>
Cc: dmaengine@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, s32@nxp.com,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>
Subject: Re: [PATCH 3/8] dmaengine: =?utf-8?Q?fsl-e?=
 =?utf-8?Q?dma=3A_move_eDMAv2_related_registers_to_a_new_structure_?=
 =?utf-8?B?4oCZZWRtYTJfcmVnc+KAmQ==?=
Message-ID: <Z2BSn91PDfwKOc8s@lizhi-Precision-Tower-5810>
References: <20241216075819.2066772-1-larisa.grigore@oss.nxp.com>
 <20241216075819.2066772-4-larisa.grigore@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241216075819.2066772-4-larisa.grigore@oss.nxp.com>
X-ClientProxiedBy: BY1P220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8529:EE_
X-MS-Office365-Filtering-Correlation-Id: a91cef25-15d5-42ea-4ad4-08dd1ded2a9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SktiTExRWm0wbWRiYkpyYjBOdzlob2hTTUgyOXJzVTZoY1ZkZmthNWtleVEr?=
 =?utf-8?B?TFVkSDJGbVVPMmVvNTB1Y2lybDB2ajFPNUFlYmxMUGhNOWgwSHQ1RTlKeElh?=
 =?utf-8?B?QVRodXYweDZrNExUL1dzMG1PV3d1MEZ2M2lWck1Na1lLYlgvUHVjQjFIbjA3?=
 =?utf-8?B?ZFdmbW9LMk8vZnhkMDAzS1N2aWNsbWYwSkhBTUJoRVprQ0RHRHBiRm82NjFa?=
 =?utf-8?B?bTJCWTk4VWdpRG9GV3VJR3pTbGhPUFFxM3lOdVpUS0lIM2NoQXVrOFdZajc1?=
 =?utf-8?B?cFRHNHQ2dkdsZkFuMDgwY2ZlNWVsZVV5YStIK1dMaDFrRzcrLzB1Ujk0cmtO?=
 =?utf-8?B?aEFWa0lYY1g0aHRoQVZLcWkxeDJ0MndzK08zRURqR2wxQzM4QVIzNFdjSEU1?=
 =?utf-8?B?MWZ3TmFNRTlaZ0JsNDh3Wm5HTC9KS0V5Q2ZQWjduQWMzR2o4bGtVc0lRbkxo?=
 =?utf-8?B?ZmlQTWRNWmsvZ3U5NTJoY1BSNGVqYUJCN3FxQ0lyZDJldXRvZzVxSVorK2Y1?=
 =?utf-8?B?R0w1bVp0RlVMa2FFOC9kOG1tdjU0M3BQQVVSemEyM21GN3kybVlIdHIzTmha?=
 =?utf-8?B?L1VzaERWSS9GTzdLMlRDcXN4TmhvUzZqTysraS9udUNrWW5NNkxFYW5vb1Uw?=
 =?utf-8?B?b3plZDlqSk9BemhTckFZSTlkYWpuTHRoMU1vWVNXeGFvZUNLQkhBU1ZWbGg3?=
 =?utf-8?B?cVdHdGY5ZndFSHJPVWRVTFFtcTltQnRVUWUzcjBRQjV4S0Q2TDZhWWNDYm1k?=
 =?utf-8?B?S0FFcG8wRWgxdFV6OFp0NXZVMTlkZ0dDMWtnTUJDNUxtc0Z5a1RabjBUL3di?=
 =?utf-8?B?L2VrWHEvazgrWGRwN2ZzQzBwdFRVRmlTMGxIQ09KYzNremg4S3o3ZkpTVUdT?=
 =?utf-8?B?TzkvZGxVSXY5UzZmR0NhaGZzRlZyQVVXMTArcDlLdElGYk91d3RIeHNmWEsz?=
 =?utf-8?B?M2ZKRnowZTNTRnhQcHFZS1p0Nzd1Q3V5bVhJamtQRmdPTis1M1I2RWZncW8w?=
 =?utf-8?B?U2VBaHVHK25rMXBad3FsQkV5OG0wMWRuVzRZUHdMQXNacjkzTkxvUHhPdjhM?=
 =?utf-8?B?RUtlTlYveHNybzhtQXpYUi9zMFlrZ2lHMVo4aFBJdGZmK1FoWk9idkdJellY?=
 =?utf-8?B?L2VsaEI4cy9UQ0thaUZHaFVZYmhvSnFvTUlHZ1hRcGgwY0RJMlRUWHBYZFN2?=
 =?utf-8?B?YzgyZFFpRlFyZDJxKzQxVzZOZkFoU0xycGh2cStpakNnQWRybkZrWnUxN1BV?=
 =?utf-8?B?eFl4eXRBRXlRV2ZHNFVRQnJ4MFBNeTM0RzhHZ3VCcll3dUpqVFFnSEY0QitN?=
 =?utf-8?B?dWd5VFJka09tMnVWV0VPMTVoaFVVN3VBdnBMWUdOS3pBdnh1MGRPYVNRaWZS?=
 =?utf-8?B?ei9yY1N5RlFnREhiVDdxd3BSTTY2RDNiT2JLdUIvVUVlZ2FtODFuL2t3NUcx?=
 =?utf-8?B?N3R3V0huTDROcENjdnRWc2cva2t1ZHdHcGFmdktUMzYxR0V2SHVZRDJ0bnBL?=
 =?utf-8?B?bzFsa3VRckJxNnM3SGVjd0x6L0M5eXZnKzlLQ0F1SlljeFVmOWlNQWNpeEd5?=
 =?utf-8?B?eHBnY2xkeCttMmFIL3MvUit2QktjTnBicHdLZGNVdDR4cFI5WjVPSElSTjlx?=
 =?utf-8?B?azJJMnlBRHJCclpGenQ5M0dpbUp5RmJLRmdyWHZSTk1VRVBtdXQ1UThTaVBm?=
 =?utf-8?B?UXN1YmVMSmZNdHoxOGVSZ0h6UjdEY25PbVlHaG5hSHJNRldqek9wNnRvbmFz?=
 =?utf-8?B?c1RYc2ZwMkRCTkFkdEJ2eitxOEFsVXlWd043OFdyYVVhYllxK0R0bk9OVHMz?=
 =?utf-8?B?Q1hqWnJsbjNPLytkT2phZXpRcXcrOFRmWWIxakZNckJnWGdXZVhRNG03bTg4?=
 =?utf-8?B?L1FxbXFHQlREWXc2aHBtTHhyUnBVWDlWOFdEWjg5MmJwaVRDZUNqNnl0VjEw?=
 =?utf-8?Q?Y3oA/8cZUxIzz6TXIwV3FgFrxo5HZ0Hx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QklyVnA2d0ZIZ3B4anZrUmNnVEEzQmh6dmFyVTFPM0xhY1V0RnBZTWNraThM?=
 =?utf-8?B?V1lXU2xWbFBRKzdQSHg5YVpOVnJ3dU1TVHJoaHVndXhZYUIyK0t1ZGU4TzZK?=
 =?utf-8?B?eWE0Qm9KTDRpUk5tYURrMWtYWEtrV0xPSnR4WWxFN0lSMGMzdSs4WE5vVm15?=
 =?utf-8?B?VXVoQUFLbUp2Zm5HTW1PeWx0TTBTbEhsV0tVZXFJRWlqdGdHdTFZNWl4S2Zt?=
 =?utf-8?B?MWg3ZGRsdEZtYWlobjFRR0hqQTY0MWpKOHJPZng2ZjlSR0gwem1QNitJUk50?=
 =?utf-8?B?QWNKbjhvRlloWXhQWWQ4bEJlSzVuK2J3V0QrUVhoN0NybjBtb2xlbzQyUmx0?=
 =?utf-8?B?Q1RCY3RObDZXN3REZU5aR0t2WnpNS1kxc1dsYjA0Q2Mwem1KV0E0QlJCS3JB?=
 =?utf-8?B?NzdjWm4vMkxRSXJEeTh5blRuYnB4UWRjcWp3Y3hnczU1c0Zud2MyenZHLy84?=
 =?utf-8?B?TXhUT0RhUG0zaTNGQ3dRWWROeGJZS0xnUW9PcXpySTM1UXdwVmwzYWg3enNM?=
 =?utf-8?B?eElkMzlxQkdHeU16Vnp0YXlFY0dUSERlQStNdDh3ZitSN1lrV0NhSmVQVU0v?=
 =?utf-8?B?SFhQbjBtWVp2U1QyTHhJSWg0VnlZV1RMM0ZOUThFaW5aYndUNURvSzlSUm9j?=
 =?utf-8?B?TWYvT1M0QkRjM3JrVW93TFpTZmJSM3FIMWdNc1BUYm9jclk0UWxsQ2tQYUlN?=
 =?utf-8?B?emdGcHNwM3YrSHZmQm5KUlN5aDhCR3FacUd5VWRNMjlsTjlET0dWVUxCaFNS?=
 =?utf-8?B?dzcyaHhWdDNCN0U2UTRtdWV1VWpnWjJpc3BrY1hIMmlsSlhxT2pZRmZ6Nkgz?=
 =?utf-8?B?VVpWTzljbHRsaFowdXFKTC9TcFZpQWZ1NjZLTGUwTjRvcEtDOElMR2NZaWZ3?=
 =?utf-8?B?YU1ZS3BicVlsTlpaem1oNmw3RXdlNHJhaUkvcm9VNTZyTEkvejluSmNOOStx?=
 =?utf-8?B?VzhWUkd2VzRSVDhMZGQ1d0dKVUJRcTVKNnVRZVUvZjJmd2RTeFRpN0luQUkr?=
 =?utf-8?B?QXpVTDBxMnQxdXAyZ0FFeTZTK1R4VlBMQWVsdXpjdzE0cVR0cEd5THdkU25B?=
 =?utf-8?B?OElyd0RRMlRUUUFNY0M5OXdQdEE2cGdmbWZWelIzbENMc09tZjBERE1LeVV3?=
 =?utf-8?B?OWgxWW1QK3kyZlpORWRlSkxZTGZUY21SWkZYQkpFS1Z3a1ZKcE5kNnlweWdj?=
 =?utf-8?B?Ny9OZE1zNDhRUVJRYUJwVGJBVExFeExXZlFnb29RUURMU0Z6eThJMENNcysr?=
 =?utf-8?B?YVlsbzMrcXFjcW4yd3kveWZmSUovYS84MGRiY1lQaVcvYk5zY2JrRXhBVTRE?=
 =?utf-8?B?MmxTd1FwNW5vaHc0L3FTMWU1UXJrVFNiYW81SnREY0pzbU9VSFBOb0xSamxI?=
 =?utf-8?B?R0lEd2VHRW1abjloMFdLbEhVN0UzTlZ5OXV3b2Q5REZDbWhJdnl2NG9tdDlq?=
 =?utf-8?B?UkpXbENRdFlOQ0dySVFxR3I5ZVZ5RFZhTnkyVDJMRUo4YWFRYkVYdVVtdkpD?=
 =?utf-8?B?dHZZZ05mZlJMT2EvcnFSckpmZTRvN3BXQ0xlYXhlOU8yVmlRQ2ZacGNOMERL?=
 =?utf-8?B?TzIvYVcxVXN0ZFdIZWZ5eWpDR0hoaUlRTVlBaGVQTWNuRzZQV3VxWkFaV0N2?=
 =?utf-8?B?TDRSbTEvclY4ZVNraDRCcWppMkFFWjBHV3p1ZHNwWmgvNk9MM3Rqei9tenQr?=
 =?utf-8?B?bjF0ZURoM1BRam1ZK0Jqa3J4VGlEZDV3MUtrdnFqMXBEd2hsNHAySlNiK3lo?=
 =?utf-8?B?RjJhemF6ckdnTk0rbXkxMjJGNlh3Sy9oOW9yY29iZHBBV3o4bGZUSkFtem1h?=
 =?utf-8?B?QmdyQkh3ZjhCbUNOVGQreUZ1aUVaOXJTNFVrZjFWdFkva2VUb1dHcWg3bWJx?=
 =?utf-8?B?eE9TSGRESGlhekRWblZJVm1OUkp0akEyOE83UXd0SVhMdXJGTVZId01xbVVp?=
 =?utf-8?B?Znh3N0xDbm9DRmV0QjBYR3N2OGN4MnplNHloakZKVkszTFJ3UXkvayszSDYz?=
 =?utf-8?B?S3JrSnBWcDFZQlJDQWFseXdlSFZXNnlZdlVza3VJcTVTdTNSRE40T2xMbEh4?=
 =?utf-8?B?Q3ZyL0hjaXE0RkIzeGJiZ1lad1VJbFRlalZzdWZEQjgraSs2YTAvVURhQUJN?=
 =?utf-8?Q?qXogSKX5OT0TPtxHGcjZg3asv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a91cef25-15d5-42ea-4ad4-08dd1ded2a9f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 16:17:41.7077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SGBeSfcidEusV/yCeIcINeXqgU3SpL0M3HYUK8DGF++xAuWJyMld3cN6eRgF/7pI1sknwKTUX6tZgVYcMsHFKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8529

On Mon, Dec 16, 2024 at 09:58:13AM +0200, Larisa Grigore wrote:
> Move eDMAv2 related registers to a new structure ’edma2_regs’ to better
> support eDMAv3.

nit: empty line here.

> eDMAv3 registers will be added in the next commit.
>
> Signed-off-by: Larisa Grigore <larisa.grigore@oss.nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/dma/fsl-edma-common.c | 52 ++++++++++++++++++-----------------
>  drivers/dma/fsl-edma-common.h | 10 +++++--
>  drivers/dma/fsl-edma-main.c   | 14 ++++++----
>  3 files changed, 42 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
> index b7f15ab96855..b132a88dfdec 100644
> --- a/drivers/dma/fsl-edma-common.c
> +++ b/drivers/dma/fsl-edma-common.c
> @@ -108,14 +108,15 @@ static void fsl_edma_enable_request(struct fsl_edma_chan *fsl_chan)
>  		return fsl_edma3_enable_request(fsl_chan);
>
>  	if (fsl_chan->edma->drvdata->flags & FSL_EDMA_DRV_WRAP_IO) {
> -		edma_writeb(fsl_chan->edma, EDMA_SEEI_SEEI(ch), regs->seei);
> -		edma_writeb(fsl_chan->edma, ch, regs->serq);
> +		edma_writeb(fsl_chan->edma, EDMA_SEEI_SEEI(ch),
> +			    regs->v2.seei);
> +		edma_writeb(fsl_chan->edma, ch, regs->v2.serq);
>  	} else {
>  		/* ColdFire is big endian, and accesses natively
>  		 * big endian I/O peripherals
>  		 */
> -		iowrite8(EDMA_SEEI_SEEI(ch), regs->seei);
> -		iowrite8(ch, regs->serq);
> +		iowrite8(EDMA_SEEI_SEEI(ch), regs->v2.seei);
> +		iowrite8(ch, regs->v2.serq);
>  	}
>  }
>
> @@ -142,14 +143,15 @@ void fsl_edma_disable_request(struct fsl_edma_chan *fsl_chan)
>  		return fsl_edma3_disable_request(fsl_chan);
>
>  	if (fsl_chan->edma->drvdata->flags & FSL_EDMA_DRV_WRAP_IO) {
> -		edma_writeb(fsl_chan->edma, ch, regs->cerq);
> -		edma_writeb(fsl_chan->edma, EDMA_CEEI_CEEI(ch), regs->ceei);
> +		edma_writeb(fsl_chan->edma, ch, regs->v2.cerq);
> +		edma_writeb(fsl_chan->edma, EDMA_CEEI_CEEI(ch),
> +			    regs->v2.ceei);
>  	} else {
>  		/* ColdFire is big endian, and accesses natively
>  		 * big endian I/O peripherals
>  		 */
> -		iowrite8(ch, regs->cerq);
> -		iowrite8(EDMA_CEEI_CEEI(ch), regs->ceei);
> +		iowrite8(ch, regs->v2.cerq);
> +		iowrite8(EDMA_CEEI_CEEI(ch), regs->v2.ceei);
>  	}
>  }
>
> @@ -880,25 +882,25 @@ void fsl_edma_setup_regs(struct fsl_edma_engine *edma)
>
>  	edma->regs.cr = edma->membase + EDMA_CR;
>  	edma->regs.es = edma->membase + EDMA_ES;
> -	edma->regs.erql = edma->membase + EDMA_ERQ;
> -	edma->regs.eeil = edma->membase + EDMA_EEI;
> -
> -	edma->regs.serq = edma->membase + (is64 ? EDMA64_SERQ : EDMA_SERQ);
> -	edma->regs.cerq = edma->membase + (is64 ? EDMA64_CERQ : EDMA_CERQ);
> -	edma->regs.seei = edma->membase + (is64 ? EDMA64_SEEI : EDMA_SEEI);
> -	edma->regs.ceei = edma->membase + (is64 ? EDMA64_CEEI : EDMA_CEEI);
> -	edma->regs.cint = edma->membase + (is64 ? EDMA64_CINT : EDMA_CINT);
> -	edma->regs.cerr = edma->membase + (is64 ? EDMA64_CERR : EDMA_CERR);
> -	edma->regs.ssrt = edma->membase + (is64 ? EDMA64_SSRT : EDMA_SSRT);
> -	edma->regs.cdne = edma->membase + (is64 ? EDMA64_CDNE : EDMA_CDNE);
> -	edma->regs.intl = edma->membase + (is64 ? EDMA64_INTL : EDMA_INTR);
> -	edma->regs.errl = edma->membase + (is64 ? EDMA64_ERRL : EDMA_ERR);
> +	edma->regs.v2.erql = edma->membase + EDMA_ERQ;
> +	edma->regs.v2.eeil = edma->membase + EDMA_EEI;
> +
> +	edma->regs.v2.serq = edma->membase + (is64 ? EDMA64_SERQ : EDMA_SERQ);
> +	edma->regs.v2.cerq = edma->membase + (is64 ? EDMA64_CERQ : EDMA_CERQ);
> +	edma->regs.v2.seei = edma->membase + (is64 ? EDMA64_SEEI : EDMA_SEEI);
> +	edma->regs.v2.ceei = edma->membase + (is64 ? EDMA64_CEEI : EDMA_CEEI);
> +	edma->regs.v2.cint = edma->membase + (is64 ? EDMA64_CINT : EDMA_CINT);
> +	edma->regs.v2.cerr = edma->membase + (is64 ? EDMA64_CERR : EDMA_CERR);
> +	edma->regs.v2.ssrt = edma->membase + (is64 ? EDMA64_SSRT : EDMA_SSRT);
> +	edma->regs.v2.cdne = edma->membase + (is64 ? EDMA64_CDNE : EDMA_CDNE);
> +	edma->regs.v2.intl = edma->membase + (is64 ? EDMA64_INTL : EDMA_INTR);
> +	edma->regs.v2.errl = edma->membase + (is64 ? EDMA64_ERRL : EDMA_ERR);
>
>  	if (is64) {
> -		edma->regs.erqh = edma->membase + EDMA64_ERQH;
> -		edma->regs.eeih = edma->membase + EDMA64_EEIH;
> -		edma->regs.errh = edma->membase + EDMA64_ERRH;
> -		edma->regs.inth = edma->membase + EDMA64_INTH;
> +		edma->regs.v2.erqh = edma->membase + EDMA64_ERQH;
> +		edma->regs.v2.eeih = edma->membase + EDMA64_EEIH;
> +		edma->regs.v2.errh = edma->membase + EDMA64_ERRH;
> +		edma->regs.v2.inth = edma->membase + EDMA64_INTH;
>  	}
>  }
>
> diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
> index ce37e1ee9c46..f1362daaa347 100644
> --- a/drivers/dma/fsl-edma-common.h
> +++ b/drivers/dma/fsl-edma-common.h
> @@ -120,9 +120,7 @@ struct fsl_edma3_ch_reg {
>  /*
>   * These are iomem pointers, for both v32 and v64.
>   */
> -struct edma_regs {
> -	void __iomem *cr;
> -	void __iomem *es;
> +struct edma2_regs {
>  	void __iomem *erqh;
>  	void __iomem *erql;	/* aka erq on v32 */
>  	void __iomem *eeih;
> @@ -141,6 +139,12 @@ struct edma_regs {
>  	void __iomem *errl;
>  };
>
> +struct edma_regs {
> +	void __iomem *cr;
> +	void __iomem *es;
> +	struct edma2_regs v2;
> +};
> +
>  struct fsl_edma_sw_tcd {
>  	dma_addr_t			ptcd;
>  	void				*vtcd;
> diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
> index 9873cce00c68..0b89c31bf38c 100644
> --- a/drivers/dma/fsl-edma-main.c
> +++ b/drivers/dma/fsl-edma-main.c
> @@ -36,13 +36,14 @@ static irqreturn_t fsl_edma_tx_handler(int irq, void *dev_id)
>  	unsigned int intr, ch;
>  	struct edma_regs *regs = &fsl_edma->regs;
>
> -	intr = edma_readl(fsl_edma, regs->intl);
> +	intr = edma_readl(fsl_edma, regs->v2.intl);
>  	if (!intr)
>  		return IRQ_NONE;
>
>  	for (ch = 0; ch < fsl_edma->n_chans; ch++) {
>  		if (intr & (0x1 << ch)) {
> -			edma_writeb(fsl_edma, EDMA_CINT_CINT(ch), regs->cint);
> +			edma_writeb(fsl_edma, EDMA_CINT_CINT(ch),
> +				    regs->v2.cint);
>  			fsl_edma_tx_chan_handler(&fsl_edma->chans[ch]);
>  		}
>  	}
> @@ -78,14 +79,15 @@ static irqreturn_t fsl_edma_err_handler(int irq, void *dev_id)
>  	unsigned int err, ch;
>  	struct edma_regs *regs = &fsl_edma->regs;
>
> -	err = edma_readl(fsl_edma, regs->errl);
> +	err = edma_readl(fsl_edma, regs->v2.errl);
>  	if (!err)
>  		return IRQ_NONE;
>
>  	for (ch = 0; ch < fsl_edma->n_chans; ch++) {
>  		if (err & (0x1 << ch)) {
>  			fsl_edma_disable_request(&fsl_edma->chans[ch]);
> -			edma_writeb(fsl_edma, EDMA_CERR_CERR(ch), regs->cerr);
> +			edma_writeb(fsl_edma, EDMA_CERR_CERR(ch),
> +				    regs->v2.cerr);
>  			fsl_edma_err_chan_handler(&fsl_edma->chans[ch]);
>  		}
>  	}
> @@ -216,7 +218,7 @@ fsl_edma_irq_init(struct platform_device *pdev, struct fsl_edma_engine *fsl_edma
>  {
>  	int ret;
>
> -	edma_writel(fsl_edma, ~0, fsl_edma->regs.intl);
> +	edma_writel(fsl_edma, ~0, fsl_edma->regs.v2.intl);
>
>  	fsl_edma->txirq = platform_get_irq_byname(pdev, "edma-tx");
>  	if (fsl_edma->txirq < 0)
> @@ -281,7 +283,7 @@ fsl_edma2_irq_init(struct platform_device *pdev,
>  	int i, ret, irq;
>  	int count;
>
> -	edma_writel(fsl_edma, ~0, fsl_edma->regs.intl);
> +	edma_writel(fsl_edma, ~0, fsl_edma->regs.v2.intl);
>
>  	count = platform_irq_count(pdev);
>  	dev_dbg(&pdev->dev, "%s Found %d interrupts\r\n", __func__, count);
> --
> 2.47.0
>

