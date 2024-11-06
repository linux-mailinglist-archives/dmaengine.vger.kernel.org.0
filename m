Return-Path: <dmaengine+bounces-3687-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD389BE2C8
	for <lists+dmaengine@lfdr.de>; Wed,  6 Nov 2024 10:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B7AE283D11
	for <lists+dmaengine@lfdr.de>; Wed,  6 Nov 2024 09:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776EB1D79A5;
	Wed,  6 Nov 2024 09:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Eol5JnHC"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98691DA2F6
	for <dmaengine@vger.kernel.org>; Wed,  6 Nov 2024 09:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730885827; cv=fail; b=hv+FC0eoSCV7Kck+EAD1NbQz8QE7xtDSTA5DlWkYyEq6N20WJJTO9NOicmhdAza3siSX5KRppCLm2DlQHMWs8ERktDAG5iVwPaLoVpIGv4JWeFEXafbimyAeBDY7mtJ0oueusujNqxxLF+N/MeCSUxYr+ev6r+ZBEtKvij64HNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730885827; c=relaxed/simple;
	bh=oEtTihOn+DeXr9CNArEUdMwsSvKonvIn6NtpDvMyntQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hFjtbeGyvz9yx45L8vy6oPVDDmFcDuTTnzZ3F/BSVyDalGkwEqc5xwl3PtmK0RecxwE6ctCGWRghK+Iju8ysJtaZvzaCZ9rRCpD69euAoPJq3GPbLdbwQKGNX8HfnJCGxeyU/Casm5BrtSn+G5y3tgu5t08B0eUGoiClYDL4E78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Eol5JnHC; arc=fail smtp.client-ip=40.107.243.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q0LOTtm+3a8X6+lhU3JC6lgFKtt23v8fQuVH78NHhpwiYIkAKudq3ENJoWJNqhjJ7fRgsn0lQB3UQPz3WsUrA+3Bo8kSlZc1OvPtRFvFBlDSfyfN8tAp0eWpGDc38lDgsZ0/OExLNKiXUATuch8WitaMI8vUU+V9GInwnTzVbAWwWHi1In8dJX+6AiVqY4j1B0gCEHMMCqjppemdc52kFa9w4p/XYW6cYZ9y8qfzwRWXJ02CkHETdmU6jlH7pN1NJxWjNEC1SJEmcXSdIyt+R2aikDBWx54iCPyZLPhddes3U4QW5KsyjbReBW/JzbBlpC4Q5a/OX7KY0UxrO0k45w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oEtTihOn+DeXr9CNArEUdMwsSvKonvIn6NtpDvMyntQ=;
 b=UuHDtNYqZ53O0G+TCsxBrnuWdupVOD2qjNvbcG5Cbye6K8xg2w79rsfqsgIu5v60RRo/kgn9FBhPviJX25ncr2cgV+9zU91KLwj5oc2yV9OfFPJkbHm8DsIJ/N9K0gtxsNOjQZFiE5Wcw2Mp95mDfPMRD3RJzKqEMHmZfHaktrSd7QZkzYRC0+VxmoDfNEgOULYNd3cVc0jerI3dJ2Czx4x0LtoO4SUKrFac2nqBc96BpgYa6ItmH72pkd53vTG/Le+/bhJ3RMxg0171lYhDII9zxAXU2Tf+Ftx+8xuOWaRhl9Ndj+YP21O8YZLrpiXjY73cItn9texLA925jE5FfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oEtTihOn+DeXr9CNArEUdMwsSvKonvIn6NtpDvMyntQ=;
 b=Eol5JnHC8867gKJ9WMN7Lsjs1KSOKQ4JtCfb5ClahLlNt7RxrlULsrwIObGkcHs1PZVKrhjLbZ+40sCYhtxDMe4gEAp30IwfszHTxTv5zTxmjvgqrLFTnLZ4wsfQVAUCvRtlLp8s/E+bAYm7UZtIt93PdOLCiFbsy/qrH0RYO9U=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by DM4PR12MB7742.namprd12.prod.outlook.com (2603:10b6:8:102::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Wed, 6 Nov
 2024 09:37:01 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c%4]) with mapi id 15.20.8137.018; Wed, 6 Nov 2024
 09:37:01 +0000
From: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To: Marek Vasut <marex@denx.de>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>
CC: =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@baylibre.com>,
	"Simek, Michal" <michal.simek@amd.com>, Peter Korsgaard
	<peter@korsgaard.com>, Vinod Koul <vkoul@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] dmaengine: xilinx_dma: Configure parking registers only
 if parking enabled
Thread-Topic: [PATCH] dmaengine: xilinx_dma: Configure parking registers only
 if parking enabled
Thread-Index: AQHbK7f72SUlhteDrkuv+BRxgRHjG7KqBxTQ
Date: Wed, 6 Nov 2024 09:37:01 +0000
Message-ID:
 <MN0PR12MB595398C872B58CA4A44BC182B7532@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <20241031171132.56861-1-marex@denx.de>
In-Reply-To: <20241031171132.56861-1-marex@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|DM4PR12MB7742:EE_
x-ms-office365-filtering-correlation-id: 3ada3268-718a-4c08-00a9-08dcfe4690d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?U1lTeW9oZ1VHdFhxVyttOFQyVEhmbG5ZaXlydmZoSEd6L3k4YlRYLzZaM05t?=
 =?utf-8?B?cjB1QW94M3pNWlE5NTBBempnRTJVMDNMb1ZmZU5CSmRGUzlSUWhKdjNzZ05T?=
 =?utf-8?B?QWZLcjZHZHludll5Z0JGVGkzeUFiNjNYV2ZEWHEvaHZpRUFFbDRWY08yUFc0?=
 =?utf-8?B?VlhnejdQcnVGbG1MUTZLajBaOUc5dldIMG1ZVFowSnY5OWlmUzlEU2ExWlp1?=
 =?utf-8?B?RitJUHpvZjMxRFAzOUwzR0ZvRDlaZW9SQnpjS0FoWERTa3kwOEU2OXArc3Z3?=
 =?utf-8?B?MUwzVk9yN0IzdDhQb1pzNUVvSThwUGlmYldQbnBXVnErQmo2UGNPbEMvbXZL?=
 =?utf-8?B?ZjFzeEZqTXZSNTM2dU5QWEZwOXFVeXQ3dWZ1cTlCQ0lBQzUzdVJTWWZxUzBM?=
 =?utf-8?B?Wm5LWVZpK1llaTlIQU5hdEFQN0NaT01NdHp5dmcxWnBJN1hHK3o3R0puUCtG?=
 =?utf-8?B?azZSNWxsNlBxbVphN2p3SFNITks3MjJGV01yV2JkbU5VWk9QTHJpK3ZjT0Mr?=
 =?utf-8?B?eDl1bWwySlhnd2xrbllNT0Zob2V4OWRZazVmelZXdE5GS2dXVE9XcER4L0Zv?=
 =?utf-8?B?NUVCQ2NhWlFScmFtdlg1Nno1azBFR3h0ZStGMjIxRXJLMGgvckVqMkZkYWtT?=
 =?utf-8?B?QzlNL0s2TjVKTnBYOHBhbm1TaW9sTFd5clk0UEk2ZFgyUGkvMUhIV1p6T2JI?=
 =?utf-8?B?ZmFESDZ2ZFJSTzAraEJnWG91bFprOUxDS2c5WnlQaHhwbzM4dDRMNG1aZ2tS?=
 =?utf-8?B?VFhENEJ2cWozMTdReE1wMkhDa3RkSGFwK2pjeUR1eFN5ZXZzSVB5d3M2eUdH?=
 =?utf-8?B?aHplM2JzT0Jwd2FYM3d3MkZBeDFuRzBUZjI1Sm1vdzJmZUxkOGtOcVFOOEFy?=
 =?utf-8?B?RFg0MG44S0l4alhhVjFKcEFYUUYyRE1GOCtCeFpTL3VoRlREOURUcVlaSnND?=
 =?utf-8?B?NjEvTmxOdExxYkE0ZFJIV0tGa1dXbUNIOTBrNDNsNUNicmR2dGI4SzVKcVR2?=
 =?utf-8?B?bTN0UlNIOWRnbGpRS3g5MkgwMmllTXBDMkpNYmh4ZVZOTzJ4T3ViWnljUTZ1?=
 =?utf-8?B?aFhEME1ISnNQNC9ZcSszYnVWaVFEc2tDNWF1WGJ4bDc1bUI3T2EvZU5CQ3Vz?=
 =?utf-8?B?NDF0a1ZyY00xY3UrYWpQYWtaMVB6d3NWTXZubzdnOFJnN0NtVTZ0UUVvVFJP?=
 =?utf-8?B?NTBEdFdHcWZlbHRJbUIxcVZTRDkvM2VtekU1NGoxZDR6UCtvTGFzZG5pTVFi?=
 =?utf-8?B?dDdZYkZpOVVEeENLOHpPc1M0bjk3a2pSK1NXbUZRMTBJOEN3bUhwQ09OWXBW?=
 =?utf-8?B?WGIyWUkzT21US0VNMS91M295OVVlbi95bHpOc3dVRkVyM3JKZWh4aUFaMlJY?=
 =?utf-8?B?cUNmYWV3bjd6UGJVMGtqNDE5MkZJR3crQ0NJMng5U2xnaDVqcFpJamxLWDlE?=
 =?utf-8?B?TjhobVY0V0Z0Y3ErVVZna2dIelkrWWJuVkRNNEErUmpmTGVWYW5vbFRUc1Zv?=
 =?utf-8?B?RU4zSTMyZXRZREdDVnBqalptM0RPTEMrQUd5RnlDeGpqM2ZtaCtlRmlDUndp?=
 =?utf-8?B?bGJrRHBwcENrR0NyMGVzOUNkMVVkTW9XdHBRZUxnSzEzVzN4SEs1WU0zcXVi?=
 =?utf-8?B?VFVVYzI2d05pNXBnUmZOZncvcncwR3JaMGRNWU9PbnF3U0c4N2ZWTFNrNzVK?=
 =?utf-8?B?L1J5QXo1Ri81cmFQdVc4OFEzWStlKy9kZEJHa2xubTJMeXZTVlVuTTBydjda?=
 =?utf-8?B?WUZsdlZBY1Z2RDVXd0YxZ2pRTkV5eDNsMG01NkU5ejBJK0lML2ZPemNCVmYv?=
 =?utf-8?Q?lvZ502l/ZM+2s0vSJX/nZRTdMqMfUNboCziYo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q0RzNHM1anlKcTRXQVpnNTFON3BwODFydnBIQjhOQ1I2eWk0QnhtVW9iUHd4?=
 =?utf-8?B?L3E3dmtUUWZDTDgrNmxyM1lNOFc2S2YvSmlPd1lWZ04yYXpVcURjWDZweWpM?=
 =?utf-8?B?QmhXcTVGVlNRbXh5eHNWczh3TGtEYXBVWFRlMk5XR1Z0MWVnZmVCUVI3N1o1?=
 =?utf-8?B?MHVCZ3pyL2xsWWJaelR5ZWhYTEhQamFTcW1ScEJGSWc3ZjlqN0pjWTBrbjB2?=
 =?utf-8?B?NWl3Zy9TVGY3STUrRHlnOUJuZG1vTzlORkNQZEV0SDExalJHVEtsU1JNM3dF?=
 =?utf-8?B?Z2xpTWlmbnkrdnFYUXZtVWx6alFLcEtkZy85TUlhejNTK1c4YTBsMTRHMWRz?=
 =?utf-8?B?NnZIdlEvUkVaWW8yeG9RdktSVk9uS25NMjF4Um5UbnRTS3VFRmZPTitNWEhl?=
 =?utf-8?B?L2VvSDBOa3YvZXg5NUs0bUc2NFZDbTRSNU9sY20vR1c0a3pBMjlTL0JUWUls?=
 =?utf-8?B?SFAvWmNiVFlXQVVxL2JGNlVnZndkY1IrUWNodWtpcEdEcTkydzR0SWtES3BL?=
 =?utf-8?B?b1BVazF4dUMzYUtYN0g0cWpabEpjTHljV2lnbjM4SkE4T1RnTkJLTXRZdU1R?=
 =?utf-8?B?RXFwelI4T2l4YzlpWE1OK1VLZmNaMzFra0I3V0hGZy8rSEJmRzU4bk8zUTlv?=
 =?utf-8?B?a3FCM2p5YVNvVkFyK2UvVG0zSDByaDBaNVY3U3hJbG84YW9MZStETUpLN01o?=
 =?utf-8?B?WU1OdDlXbk5PbHc5dTFVM0ZxazIra1NnSTRIUG1IcEE1aFN3S253VFIybmdJ?=
 =?utf-8?B?NUNnWS9ubnFiaDBUQXBuUTg0ODRvM2thOVUyejNRL05IenJpM2FyK1U1dWNv?=
 =?utf-8?B?Z1lUZmh6TTZXZFA1YTNwTmFGbk5CNE1talVUa0s4cGp3WGJhYTRFMVU3akRi?=
 =?utf-8?B?MlVKdzFJMmp5RXIyZFFHb25OZmJUSFdQY2dJaUJiU05HdXg3K1JxMWlrYURG?=
 =?utf-8?B?QnJjNG9Kc1d1MXgxSWdCUWYwRVBWNjU5dDNjM29SN3RXUGtUdVF6QnJnY1c1?=
 =?utf-8?B?NmU2NmtmT1BBdk1Td2NkUmt4cm1TODhjbW9STkJ1cXZTMnZ5aWJHMTNFbVU0?=
 =?utf-8?B?Qnp6ekdSQ0lJUTRCZWdJRDV6RGt0UDc4V3NlUlh4NUZkWlJzbGFIdlBZM2Uy?=
 =?utf-8?B?aXNMc1NaYll2ekJrcThWaHNBeEVmV2xyVlpOcDJMWTAweUdVcDM1V0tZc1A2?=
 =?utf-8?B?WSszSVU2aVJBcGg4ZFQrYW9jdTlELzhEWEJFM1JMY25kdXRkb0M1WGk2MzFl?=
 =?utf-8?B?ZW5WeElURXFKb3dtZkRqWU5ubGpwQkIzQWxTWlZIK3p0d1lkS2syWXRGOG5o?=
 =?utf-8?B?SGRWZEFyM1pXMWI0dVJTQkxTeXpWMlNNNFhibURrRmJIek45Zmo5N2dHZDBK?=
 =?utf-8?B?WENZZ2srT1FJSFhxNFQ4UjN6bWR4RkVWZ0lKTElTbVdTeVYxa28vVlc1dmZ6?=
 =?utf-8?B?Z1ZjOTRKRVZMd0hONXFSOFp4R3R0cGZKOEZuN1lWSlhzZzRjdUtuTGxKYU5j?=
 =?utf-8?B?c01jVnZ4Rm13cFBPVi96RmNsWDVrYjZpY1NGUEZLMnZCVjJBSVR6S0pCMzFL?=
 =?utf-8?B?aytodFB5TnkxSTZ0TjVUYXFKRElNaFJRUEhtbTBIVzNGOSsrM2t0NVBmOGky?=
 =?utf-8?B?MWR1WTRmQmxFZEFUb0Vtb1NxUXVONGFDb2h1bS9UUmczZlNyS0NjRVlMWjVM?=
 =?utf-8?B?Vm5HYzg2WGJITWFJWkExSnpZbDJFZU1KOGtCOG1mcWs3WE9lYjRKaEhjWFF2?=
 =?utf-8?B?WUJIcW5UQXRDRUF1RmFPZmVsZWd2VTdBcE44Q3JkMlR4dE5POHNkRHZiNnR1?=
 =?utf-8?B?bVRzZkxxR2hzMVhVdVVOU1BISGMrKzAxdmQ4bXFQTE4vYjFuVGh6aHd4dVRT?=
 =?utf-8?B?OHBScTVYQlRsWjYvVEQwbVVvR2dYcy9WWTRHaUlEU0dRWUtzQkNqM00rR0lk?=
 =?utf-8?B?bjFxUXJUTGdPek92dlRsWXQ4UzdWSnJOdFJGVUFWdGxITGlJVjBWL3VWbGQ2?=
 =?utf-8?B?ZXAwZlZySFZ4dkthcWtVOWhWVkd5K1FZZG4yVUJiWHlWUVNLY294eHBXeUV5?=
 =?utf-8?B?dVM3bE5SdUprNnp6NWtENlhMY0FZdSs4Z2J0YVg1dkR6OER4VUQ2RnJmazQ3?=
 =?utf-8?Q?sBYs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ada3268-718a-4c08-00a9-08dcfe4690d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2024 09:37:01.0782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 95s3AOs6aqdoF6Fp4x3xAGOYI/41K7UeulApTRgl8jUnTaOuGaJFaCPLrnLp0bad
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7742

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJlayBWYXN1dCA8bWFyZXhA
ZGVueC5kZT4NCj4gU2VudDogVGh1cnNkYXksIE9jdG9iZXIgMzEsIDIwMjQgMTA6NDEgUE0NCj4g
VG86IGRtYWVuZ2luZUB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IE1hcmVrIFZhc3V0IDxtYXJleEBk
ZW54LmRlPjsgVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLQ0KPiBrb2VuaWdAYmF5bGlicmUu
Y29tPjsgU2ltZWssIE1pY2hhbCA8bWljaGFsLnNpbWVrQGFtZC5jb20+OyBQZXRlciBLb3JzZ2Fh
cmQNCj4gPHBldGVyQGtvcnNnYWFyZC5jb20+OyBQYW5kZXksIFJhZGhleSBTaHlhbQ0KPiA8cmFk
aGV5LnNoeWFtLnBhbmRleUBhbWQuY29tPjsgVmlub2QgS291bCA8dmtvdWxAa2VybmVsLm9yZz47
IGxpbnV4LWFybS0NCj4ga2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gU3ViamVjdDogW1BB
VENIXSBkbWFlbmdpbmU6IHhpbGlueF9kbWE6IENvbmZpZ3VyZSBwYXJraW5nIHJlZ2lzdGVycyBv
bmx5IGlmIHBhcmtpbmcNCj4gZW5hYmxlZA0KPiANCj4gVGhlIFZETUEgY2FuIHdvcmsgaW4gdHdv
IG1vZGVzLCBwYXJraW5nIG9yIGNpcmN1bGFyLiBEbyBub3QgcHJvZ3JhbSB0aGUgcGFya2luZw0K
PiBtb2RlIHJlZ2lzdGVycyBpbiBjYXNlIGNpcmN1bGFyIG1vZGUgaXMgdXNlZCwgaXQgaXMgdXNl
bGVzcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1hcmVrIFZhc3V0IDxtYXJleEBkZW54LmRlPg0K
DQpSZXZpZXdlZC1ieTogUmFkaGV5IFNoeWFtIFBhbmRleSA8cmFkaGV5LnNoeWFtLnBhbmRleUBh
bWQuY29tPg0KVGhhbmtzIQ0KPiAtLS0NCj4gQ2M6ICJVd2UgS2xlaW5lLUvDtm5pZyIgPHUua2xl
aW5lLWtvZW5pZ0BiYXlsaWJyZS5jb20+DQo+IENjOiBNaWNoYWwgU2ltZWsgPG1pY2hhbC5zaW1l
a0BhbWQuY29tPg0KPiBDYzogUGV0ZXIgS29yc2dhYXJkIDxwZXRlckBrb3JzZ2FhcmQuY29tPg0K
PiBDYzogUmFkaGV5IFNoeWFtIFBhbmRleSA8cmFkaGV5LnNoeWFtLnBhbmRleUBhbWQuY29tPg0K
PiBDYzogVmlub2QgS291bCA8dmtvdWxAa2VybmVsLm9yZz4NCj4gQ2M6IGRtYWVuZ2luZUB2Z2Vy
Lmtlcm5lbC5vcmcNCj4gQ2M6IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0K
PiAtLS0NCj4gIGRyaXZlcnMvZG1hL3hpbGlueC94aWxpbnhfZG1hLmMgfCAyMCArKysrKysrKysr
Ky0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDkgZGVsZXRp
b25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9kbWEveGlsaW54L3hpbGlueF9kbWEu
YyBiL2RyaXZlcnMvZG1hL3hpbGlueC94aWxpbnhfZG1hLmMgaW5kZXgNCj4gNDg2NDdjOGE2NGE1
Yi4uODdkYjM4MWZmMTI4NiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9kbWEveGlsaW54L3hpbGlu
eF9kbWEuYw0KPiArKysgYi9kcml2ZXJzL2RtYS94aWxpbngveGlsaW54X2RtYS5jDQo+IEBAIC0x
NDA0LDE2ICsxNDA0LDE4IEBAIHN0YXRpYyB2b2lkIHhpbGlueF92ZG1hX3N0YXJ0X3RyYW5zZmVy
KHN0cnVjdA0KPiB4aWxpbnhfZG1hX2NoYW4gKmNoYW4pDQo+IA0KPiAgCWRtYV9jdHJsX3dyaXRl
KGNoYW4sIFhJTElOWF9ETUFfUkVHX0RNQUNSLCByZWcpOw0KPiANCj4gLQlqID0gY2hhbi0+ZGVz
Y19zdWJtaXRjb3VudDsNCj4gLQlyZWcgPSBkbWFfcmVhZChjaGFuLCBYSUxJTlhfRE1BX1JFR19Q
QVJLX1BUUik7DQo+IC0JaWYgKGNoYW4tPmRpcmVjdGlvbiA9PSBETUFfTUVNX1RPX0RFVikgew0K
PiAtCQlyZWcgJj0gflhJTElOWF9ETUFfUEFSS19QVFJfUkRfUkVGX01BU0s7DQo+IC0JCXJlZyB8
PSBqIDw8IFhJTElOWF9ETUFfUEFSS19QVFJfUkRfUkVGX1NISUZUOw0KPiAtCX0gZWxzZSB7DQo+
IC0JCXJlZyAmPSB+WElMSU5YX0RNQV9QQVJLX1BUUl9XUl9SRUZfTUFTSzsNCj4gLQkJcmVnIHw9
IGogPDwgWElMSU5YX0RNQV9QQVJLX1BUUl9XUl9SRUZfU0hJRlQ7DQo+ICsJaWYgKGNvbmZpZy0+
cGFyaykgew0KPiArCQlqID0gY2hhbi0+ZGVzY19zdWJtaXRjb3VudDsNCj4gKwkJcmVnID0gZG1h
X3JlYWQoY2hhbiwgWElMSU5YX0RNQV9SRUdfUEFSS19QVFIpOw0KPiArCQlpZiAoY2hhbi0+ZGly
ZWN0aW9uID09IERNQV9NRU1fVE9fREVWKSB7DQo+ICsJCQlyZWcgJj0gflhJTElOWF9ETUFfUEFS
S19QVFJfUkRfUkVGX01BU0s7DQo+ICsJCQlyZWcgfD0gaiA8PCBYSUxJTlhfRE1BX1BBUktfUFRS
X1JEX1JFRl9TSElGVDsNCj4gKwkJfSBlbHNlIHsNCj4gKwkJCXJlZyAmPSB+WElMSU5YX0RNQV9Q
QVJLX1BUUl9XUl9SRUZfTUFTSzsNCj4gKwkJCXJlZyB8PSBqIDw8IFhJTElOWF9ETUFfUEFSS19Q
VFJfV1JfUkVGX1NISUZUOw0KPiArCQl9DQo+ICsJCWRtYV93cml0ZShjaGFuLCBYSUxJTlhfRE1B
X1JFR19QQVJLX1BUUiwgcmVnKTsNCj4gIAl9DQo+IC0JZG1hX3dyaXRlKGNoYW4sIFhJTElOWF9E
TUFfUkVHX1BBUktfUFRSLCByZWcpOw0KPiANCj4gIAkvKiBTdGFydCB0aGUgaGFyZHdhcmUgKi8N
Cj4gIAl4aWxpbnhfZG1hX3N0YXJ0KGNoYW4pOw0KPiAtLQ0KPiAyLjQ1LjINCg0K

