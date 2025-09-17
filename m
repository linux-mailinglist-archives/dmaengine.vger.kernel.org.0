Return-Path: <dmaengine+bounces-6597-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DC1B7D2C8
	for <lists+dmaengine@lfdr.de>; Wed, 17 Sep 2025 14:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8636D582A99
	for <lists+dmaengine@lfdr.de>; Wed, 17 Sep 2025 09:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB1534574B;
	Wed, 17 Sep 2025 09:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YxZXKmCJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010002.outbound.protection.outlook.com [52.101.84.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AF826B2DB;
	Wed, 17 Sep 2025 09:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758102854; cv=fail; b=ADlrSMnrgZpeNZQ5Xg4MM1LkQAM+8uvaSZAmsdL5unneMJYbvgMxNFweNpBh0tMF0SeCdMxIgZu4gChB83q32cFQ0geGtB+rbzfPSDvb3RuMAzwmjvcGe5FiMHqzXjeCsLKfzdiLZPpqSfm3xl7/mozaO4E7agyUi3079bMtne0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758102854; c=relaxed/simple;
	bh=AmecCqs68IPb01gG2YBO2KDnyPaHp4H3EXDOk9BN9ls=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=jPdRD+XU+sPw5ga7d14ue/FsoBX9adT9VDS7T84gRkX6d1LTp3PxR89Q+tSVMeqjCaKqJzcCfoX+auAN0bCKnHnoC/j4AwefhqfByYdmo+DHHs7ZSa5gwTe+ZyjB5ZaX1Wem8z4Zv4CkvhRg7CoV3uCVdn+aqiIHSX9SLa0cAKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YxZXKmCJ; arc=fail smtp.client-ip=52.101.84.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cjG24FmWvuQW6jj4EepCsI06/NSim5R4sxy7L/Aqmxun6ZEBINK9acV2KSQPVwAjqcW97z8JFzhVIMVNuWE9f6OSCR9kQqNruvkFrVXP8XJK6hV+/vhTg59ZFds/j6SgtvG4mEXV+2sQM8+tFjZocuZsL5FOs7p2HNtWDv4RLhMqCp/KQOhpZxIkKakSky6HlAqHyO4KMA4TLlcWyM+ly2JBasDK1wCG+jb1My9NxyFyWalwj3BEjBAQzeNeKieOAIP6dVBnh1A6012yRdHdFmzYSCk8EUA0uHXqwIpq4T4RqYn7P1BfOwoTIacJjX6XKxtX72ax1J/8EDf5iaBwPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6WUWXSbBLnay2Ma4YpQRuw6h7Ful4YqIrfMxPkSIwc=;
 b=W70JaIPNaGM9uYnqI5PcaqZNM6eGEdkRYfaF544Wi4PLRqChZvBB/B8JMssbKtWDA+e7wUw+8hblCbL1J0EXkfxKpfTWiIk9bL3i4+A1+pMiguAuN8maP5ZmvUrg/BUxGw0nZf3UwOHq95QEhMmXGcPEkNU5+nmsLLVAiOkkaIU0A8EcYRiW/FtsIH9Wgrr9/G+m4ZpuxxZadQEoUCvRN5KVhZghGDe06O+h+kwwZ+JLZIJf4I+YcgGTYDBcs0CibDRmJC5k8SkjRWUmQ4JNimf5aluuNqG3sxLcySNW7r854D6IZSAwcMH0QuXRqJqObUGYckFbmTPUrua4UMRaHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6WUWXSbBLnay2Ma4YpQRuw6h7Ful4YqIrfMxPkSIwc=;
 b=YxZXKmCJv2jAeBm/hY1Vh6HKEcYqq2T+bC1CxJkW6BwOSUUS9sk2I+EvybMFeuPkbQg1W8oB5tKKyFlTXVgdKSNnzPDJyZTFQHzjhhJmjzikKf1YqHOKtR8m7P+OVOrm9cFYVnWv2k5k3BF+HDYe77fripPTNLDV3h66wUAnFYTDboCv5mrskJ7fadE+KkuXDGL1jjT22MW1siwV27qR2pmAt9qYAGnuPI00LW08hpGmUAmBU/CyMjYaFb4B1gqxXTBQ8/X8N81Vh+zEJov3RatotFiFJjwZEqCzu88+LXwrjPgKYi5EEr+urK1Xe2hcXYVIfDuETqO14ySZF29Lww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by PAXPR04MB8096.eurprd04.prod.outlook.com (2603:10a6:102:1c7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 09:54:07 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%7]) with mapi id 15.20.9137.010; Wed, 17 Sep 2025
 09:54:06 +0000
From: Joy Zou <joy.zou@nxp.com>
Date: Wed, 17 Sep 2025 17:53:42 +0800
Subject: [PATCH] dmaengine: fsl-edma: fix channel parameter config for
 fixed channel requests
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-b4-edma-chanconf-v1-1-886486e02e91@nxp.com>
X-B4-Tracking: v=1; b=H4sIACWFymgC/4WNQQ6DIBBFr2JYdxpA0dCV92hcWGaoLAQDDbEx3
 r3oost2+f7kvdlYougosVu1sUjZJRd8AXGpmJlG/yRwWJhJLhXXooNHA4TzCMfVBG8Bx1a0itd
 WasuKtkSybj2T96Hw5NIrxPf5IYtj/RHLAgQgKam5aTppsPfrcjVhPsp/NG3QNsiVrWv91YZ93
 z9iJDu45QAAAA==
X-Change-ID: 20250917-b4-edma-chanconf-da616503f29f
To: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>
Cc: imx@lists.linux.dev, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Joy Zou <joy.zou@nxp.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SI2PR01CA0019.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::12) To AS4PR04MB9386.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|PAXPR04MB8096:EE_
X-MS-Office365-Filtering-Correlation-Id: d66d0039-4f25-4b8f-7c49-08ddf5d02448
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c3g5aEVpOUM3RVJlRE1jMWF5L1V1MVdoeWxBQzV6eEQxdTdIbU4ycksydFgz?=
 =?utf-8?B?YXZMdUxtZDIwczZvNzNtcFpIbDBIUzNTNkVmVnl1bEtVUE5CNGxCMUZ0dmpT?=
 =?utf-8?B?UGpFOHdPTmVXM1VYRmdpT2dsV0xFem9pTEl0UGlJQWNoMVg5c01jSGFtMGc1?=
 =?utf-8?B?YTNkOG9QVDUxVmk1VC83VFJtZ2tGY1hyNCs1WVZkYzBEWmNyeTZPcDRCYlJX?=
 =?utf-8?B?YkpEMCtxZTlmUjZFM0xibzhKT3haRXB6S25iaVdSRlptQjhMWWtYMHJ3OTdy?=
 =?utf-8?B?ZlBwcGFKYXozeWxNc0JodkZGN2l3UnVaTjZFRnFLUVJSTkFvOHpnb2dlK3lM?=
 =?utf-8?B?VllCT1hwbjZjQ3U4WTl1TGdvak9PVStDdjk0Y0oxQUxWZXRTZkdQYlExQkR3?=
 =?utf-8?B?bUxlcUZ0RU1YYmQwTWFzYWxLNjhBcHlhQ2ZJaTdNbnlMdVNlczhaNWVVT2xr?=
 =?utf-8?B?bDY2cC8xL2V6OHBxTmhjMU41WENKZkxJNzFWeERaTXFZMzBLRnptaFozTFVx?=
 =?utf-8?B?b3M2MkdrdnFwNFpvU0t5VmNybk92b1hQQjEyNjFTRGhselU5SDJyTEo4Qmpp?=
 =?utf-8?B?RVlGMWU5dHJTWHBWakZWMlNFYk5vQ2JCdHJBRUR1d255YUtubmd5MWJCcHFt?=
 =?utf-8?B?WWw3M01XbmNrN3JmYkpMZktjbG9LNWtGc0tWeHBDbEpyWE41U080a2cxSFRu?=
 =?utf-8?B?WW1qVHE2MW16SjRGdlJra1pBZU5iKzRYbnNRbk9hS3hzL3lLOE1aRFNOYWZT?=
 =?utf-8?B?YmhVMjJUWTN4cFlSeE5EWm1lSFk5RFNhOVZna0RZOUZTa3h5cm5BTW5raXcr?=
 =?utf-8?B?QldqZ2JXL1d4Zm10VVZ6RXZoTE95SGlKaVZOcHJNeEQvcWI5NS9mRi9JQUVm?=
 =?utf-8?B?MU52c2pTRXpPeTQ2cEIwdXFXY1ZNb1FFMGFTVU1sYS9Udk56SlVNbXkwNC9m?=
 =?utf-8?B?d1ppK0FnazNzcWtMOTNXYWhNbEhSTFhHVmdadW9GRHlLQW9IM1lHRHZvVzZ6?=
 =?utf-8?B?eUFPY2JINHZvQ0VCMmQzeUZoeVU0VW9nVDliaUh3ZzBrMWlPdkszMzZwMkJp?=
 =?utf-8?B?OFk4Mkhua0dQaW45VEp0eFlwcjBkT2RqRWpwN3lKREt2YWJRWlBQcWxCRVA0?=
 =?utf-8?B?SE5leUlXNHdSUFJQS3VRTkRhRWtzWUpTeTgzYXBOeDhWNlJXWGgydDFUVSt4?=
 =?utf-8?B?TFZTYWt4NndzNlZBdVB2U051dDRtbWxabWd3ZkJxSGdSbDJ3dWRBOEl5VnhT?=
 =?utf-8?B?RjVqOWlkMFV4NzlTL0lVdzBjellMakV3WGwwaHprM3BDbWhMRTZrMldFYmZl?=
 =?utf-8?B?NTFIaEVKNUdNQUhwcUM4VFhjQXE0Qmg2OEtJNWFkbTlSdHRCZU5waFpsUzho?=
 =?utf-8?B?ZWRmWGg4N3JxQ3hZa0R1VEtkSk1PL00wWUZKVHZ6NVA1bkRBTnFyejNqTzhG?=
 =?utf-8?B?K2JWQ0VXUWFERytHNDdwOE00RXBrREJ5d0NXRDlQeSs3UUw3Qk5NY09YUXFY?=
 =?utf-8?B?TjM5eHBYbDFxWEFRUStJMlRIYzJKQVFjVnlEa1gwR1NNdVg4bU9OejkwQlR4?=
 =?utf-8?B?TmI3dzEva0FGUHBRa2puNmpEak9CMHFMQUpxR1kvbUwvU29MM2FSSTYrY3NF?=
 =?utf-8?B?RjZCd3B3NmNjang0UlVTc2NqeVB1UW5FV1VGazhUeWl4bnNDNEVqemV3SkZo?=
 =?utf-8?B?M1dpQm1pdzhVODRJWUNaV2tWbzd6UGE5UXhMNWhYVEE3TEw2c0dWRXVkOFRV?=
 =?utf-8?B?NktiMmRjbm41SG1yTlVXQ1F2SjJUVjVaSWF5N1cwdjdYV0lMbHRUQWRMdk43?=
 =?utf-8?B?RDhpcEZpL00rcGd1Q0wvUkR4WUhab0hzRFN1bjV6TWh0aEZ0OUxpdllXWjVm?=
 =?utf-8?B?NmJWV3hQUzEvcHV3bElOTkRWZjl2ODRlM3JONUlqMTJzWUg4QVc2MzZNcjJS?=
 =?utf-8?B?cXZudWJiL0pYbmpEdmt4RXBzRU5qWnc3cUlQSlJVOXRnOXdieUFWZE1KT2hp?=
 =?utf-8?B?eDFKK0kxaXBBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bHZ4dnZrZ0U2SlVMMVpudnZEbGJtaG1vekRYYWtiVXFXV3hwMFNjbU1XK1B0?=
 =?utf-8?B?SHZ2ZnhmU2xFQTBLVE9sUDNzN0J6dGZjOHJ1Q2lkRHpIMStXQVNtME5TUjVY?=
 =?utf-8?B?dERSVW5nRzVBZDJnb01Ea3ZlbW5nYVlVY0ZNTmNReThMdjFLSnZWanlDOFJ5?=
 =?utf-8?B?SngzTjY3bGJpQTd1dXQ3RWFiNEZ5THRFWlVTQ1VoUXc3MHpGRjFZak0wUnIw?=
 =?utf-8?B?VXIzK1NsM2h6TE5GWCsxaUphVGljaGRndlNrdndBMzh0YmFES0t4cUppQytW?=
 =?utf-8?B?SSswVlBDMDhyeXBucnNtdHZ5dlQzQnBTUGNVUVVoN3BjQy9GcUQwbXQxcW54?=
 =?utf-8?B?emRTZVFrdktHZG5uSFN0bEhKMmZjdlNBY1JIMjIwcXZtUFFRVUh3OCtBL3A1?=
 =?utf-8?B?MEIyOUhLajdvaFVOeXViRnVnNmxJSEtrb0x4aVhOcmg5OWRzekk5NHhNY1A2?=
 =?utf-8?B?L25aRktSbzNtZDFzdVgvRGNGb3I1MVR2cHYzRW1OWXcva0d2WDBuVlZvVm02?=
 =?utf-8?B?T3RxVnRrK2tyMWpESG5DK3NZeDA1eWVXSk1QSWhjbkxUTnNSekVDTnBvd1J2?=
 =?utf-8?B?L3h2WkcraGdnejFpdUJpZUdXeU9kZ1ZXVEc2TlBVaU9SWk9pODVJTXJqTkhG?=
 =?utf-8?B?YVlWeTBwR2gzL1JhN2RyNE9FRHNXOFE1TkxQckJzcEt6UVF2VHJRSEtyL2NO?=
 =?utf-8?B?SzdUUnNWSEY1ZmhKNlZiSmR1QXFrT3BPbFJsVlhXTFFveUtrcUJhQ01RODl3?=
 =?utf-8?B?ZHd6cW16S0VWcXVxQ29PTnloU1o3RnJ3ZytMNnZQeGlxZmNHNlRUa0tCZnJh?=
 =?utf-8?B?U3dMTjBmOUU2NUV4T0pZRGZSUXpncktNT2p4akRUWE5lVEl6ZHczVUpYWEhE?=
 =?utf-8?B?b05EYVBZRkhXeXNOcTlleUd2ZmxDKzZDUDk1MFMxK0YyMlZjc2c5WndRQXFI?=
 =?utf-8?B?OXFJM0FoMnJlNkJlRFF0NEdXMG11ck1VY1dqMEJ4ODZPd051YXhYRkdaNExx?=
 =?utf-8?B?RnZwdVRMODBacit2UXhMZGc5Q1d4bTJiV3Q3a29aZDh1RlZSbkRhQ0lLTXY2?=
 =?utf-8?B?U1FORHB4V1VUa0RLN1FsVEZVWm9nTkFnd21TU0xuNjNTSEdmdXV5cEJ1RHh2?=
 =?utf-8?B?SjB2SmtDS093OG05ajUrdTF1dWRLUnM3TW9TbzhNNjQwVzB2Q0RMY280UlNZ?=
 =?utf-8?B?Zlpvd0p4NnhpQkcrYkxRVUxjbjRzTUpTOHlJY1RldHZKb1ViRElGWnZTYWZ3?=
 =?utf-8?B?bG1FWkwvbWlBeFozQW4rR0JyeDdsNGxjK2RGK3BiOVJMQlFDenJtY3J6R2Fi?=
 =?utf-8?B?Nm5DY3dQMUNjZm8xVENFT01USXdlSGxlTzZUUWF5alJaQlFvMTM4c01lS1Vh?=
 =?utf-8?B?K3NsUEYrdEw3czhrdkF4K0hRTFZqMllXTW4vU3F2UXJwc3RYZ21xUStrTHBO?=
 =?utf-8?B?eVJGcGNiOFZCSk1rQWp5NGZOSnFRKzN5MmdUeG5FTkZGaWhjTUpXTHdram9N?=
 =?utf-8?B?YXVrMjVCeVoyU2E1cVBmbXJCUWJ2R0VkN3d2c2lsdmlacldnUUszdk04SXdO?=
 =?utf-8?B?UXJTNFVBWVE3RDlqMzg2L1BZVTJ5Z3p6dDZuWStXVmEyMFJBeGhzQTVUbGI3?=
 =?utf-8?B?amZDRzVETlVRT2dFUUhWT0N6RFFHOHExYXMrbjU3Qkw5bHJVenZSclVqbTZp?=
 =?utf-8?B?dkw0K3dPaFRYdW4vM2JvUEFwbkRzdW5vZVdObGpsL2hNZDl2R21wanZCUGhh?=
 =?utf-8?B?WTFXUmMrOXNWK1ZwKzRYT2h2VkxGdG04aW1heldLbWdlS2JSMFJTMlY4aFg5?=
 =?utf-8?B?YTBlUGVSK3FkVERHZ0NCQTEvdFp3MnZETEQxUklyblFRRDBYOFNpUWpoa0tn?=
 =?utf-8?B?VXM3bVRLbktYY0lKcldhdDBveGpvQjhhajZEbVViYklacTM2dGJOek1xeVZZ?=
 =?utf-8?B?MnI0TTEraDRpRGcxTHF4N2tyUlBXaFFZQWdSSEp5Y2NsNms1dTRDZzFhUUJF?=
 =?utf-8?B?Q0R0NlpYclNKSzBoY1VMS0IrS3RuMjZjSFpNSk9POTY0VWdWYUY3WjV2M3Nx?=
 =?utf-8?B?L2hhTVVMMjg2NG1LaUhSYUJtdGc5cC9SdTMrckIxZG5yZkc2WGMzUXpSZHd3?=
 =?utf-8?Q?zQDO7rIn748JRuPWCn83ubwQX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d66d0039-4f25-4b8f-7c49-08ddf5d02448
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 09:54:06.9564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /8YC++FfhhQ6nOHmGs3C5Kw7sVRhmXyfcAr6NjXHC9/2LAooOjNnnheoyBmP9JYN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8096

Configure only the requested channel when a fixed channel is specified
to avoid modifying other channels unintentionally.

Fix parameter configuration when a fixed DMA channel is requested on
i.MX9 AON domain and i.MX8QM/QXP/DXL platforms. When a client requests
a fixed channel (e.g., channel 6), the driver traverses channels 0-5
and may unintentionally modify their configuration if they are unused.

This leads to issues such as setting the `is_multi_fifo` flag unexpectedly,
causing memcpy tests to fail when using the dmatest tool.

Only affect edma memcpy test when the channel is fixed.

Fixes: 72f5801a4e2b ("dmaengine: fsl-edma: integrate v3 support")
Signed-off-by: Joy Zou <joy.zou@nxp.com>
Cc: stable@vger.kernel.org
---
 drivers/dma/fsl-edma-main.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 97583c7d51a2e8e7a50c7eb4f5ff0582ac95798d..f0c1a2a3fd26e663b3f0b918ff979a68af510fbf 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -317,10 +317,8 @@ static struct dma_chan *fsl_edma3_xlate(struct of_phandle_args *dma_spec,
 			return NULL;
 		i = fsl_chan - fsl_edma->chans;
 
-		fsl_chan->priority = dma_spec->args[1];
-		fsl_chan->is_rxchan = dma_spec->args[2] & FSL_EDMA_RX;
-		fsl_chan->is_remote = dma_spec->args[2] & FSL_EDMA_REMOTE;
-		fsl_chan->is_multi_fifo = dma_spec->args[2] & FSL_EDMA_MULTI_FIFO;
+		if (!b_chmux && i != dma_spec->args[0])
+			continue;
 
 		if ((dma_spec->args[2] & FSL_EDMA_EVEN_CH) && (i & 0x1))
 			continue;
@@ -328,17 +326,15 @@ static struct dma_chan *fsl_edma3_xlate(struct of_phandle_args *dma_spec,
 		if ((dma_spec->args[2] & FSL_EDMA_ODD_CH) && !(i & 0x1))
 			continue;
 
-		if (!b_chmux && i == dma_spec->args[0]) {
-			chan = dma_get_slave_channel(chan);
-			chan->device->privatecnt++;
-			return chan;
-		} else if (b_chmux && !fsl_chan->srcid) {
-			/* if controller support channel mux, choose a free channel */
-			chan = dma_get_slave_channel(chan);
-			chan->device->privatecnt++;
-			fsl_chan->srcid = dma_spec->args[0];
-			return chan;
-		}
+		fsl_chan->srcid = dma_spec->args[0];
+		fsl_chan->priority = dma_spec->args[1];
+		fsl_chan->is_rxchan = dma_spec->args[2] & FSL_EDMA_RX;
+		fsl_chan->is_remote = dma_spec->args[2] & FSL_EDMA_REMOTE;
+		fsl_chan->is_multi_fifo = dma_spec->args[2] & FSL_EDMA_MULTI_FIFO;
+
+		chan = dma_get_slave_channel(chan);
+		chan->device->privatecnt++;
+		return chan;
 	}
 	return NULL;
 }

---
base-commit: 05af764719214d6568adb55c8749dec295228da8
change-id: 20250917-b4-edma-chanconf-da616503f29f

Best regards,
-- 
Joy Zou <joy.zou@nxp.com>


