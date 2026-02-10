Return-Path: <dmaengine+bounces-8879-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOAlLWhOi2mWTwAAu9opvQ
	(envelope-from <dmaengine+bounces-8879-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 10 Feb 2026 16:27:36 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E561311C746
	for <lists+dmaengine@lfdr.de>; Tue, 10 Feb 2026 16:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5CC43033897
	for <lists+dmaengine@lfdr.de>; Tue, 10 Feb 2026 15:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75AE36EA82;
	Tue, 10 Feb 2026 15:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KMaBGruz"
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013065.outbound.protection.outlook.com [52.101.83.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F772EC0B4;
	Tue, 10 Feb 2026 15:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770737251; cv=fail; b=NFSmnzMi6IKltrLFzXqxIKDfihUhQkgR4q+dDXuT9Mbg2xZb1bPPJwdQLoab7YFrPg67BakG46n9xaeWXDrSUldFwA5uKTefmo+NpVVGAzTHlQ8yDNEoN5NL6qQXSJRVX4A3xF0ZZmGJs6uLAq2OblO9JbL55UeQDvCKF2vh0RA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770737251; c=relaxed/simple;
	bh=B2A36ARO1kUN50+BrvcNXK7FWPE53zcHJxx5Ic8ccWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IDdLPZw13eLAArUrOOMf6OUbJwY8q0j/jHUyq9PJH8qs6AQ7AszQQbW1KH5NIRGK8qzawgt+a4pJFuBg1I3dV5MBFv271eU3r6if5eAJr1EhICISCj2zZM0o6wkaN7lmPFWQ5nbthWInsaWS9ZdguwhqeNSpatcrMD2WUIWtARY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KMaBGruz; arc=fail smtp.client-ip=52.101.83.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vRTKPSQeo6I4kxQzwNs2gzY74Bgd+EpJv6kliYhYWikGFXTo8St92QblGKsf1Dcec4ncW4JN182H9f/wMluxuJ19nQiAlfeCRh89te0tjsGZajSi8OK6hLbfszNubgWrNfQEv0PPIqHULDLwjWVDM10utQEF+f/Qk/OoMAzvEv9gtBTwv+8dY5xz7KJ4MEd9nioRt944XgWeEs3/SmhoM2NpNtIeJMlUw83W837+7BxMfHKGivPcBxJBbIl6Cd7eXkpuey62jUfJRiUNLoysAE5GTcHdX2zMYBodV7Ja8HSeoGtGTa31/2R0l0jFk0wXKuhQdj2lI5Po0/VKU0k3tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UxJB9hScs/uOxSoorp+zDEhMLQv8XAbjW4Ou72P628k=;
 b=hKqZwCnsapHaJeUoGpAPV+UABal1GwWbjwF/UKjdtPSaw/J4Z4BWl7VQBGdQpKO1usQgTJD6IdS5GbS/OdNOnsaS9mlGjcReFKV4usy3qqNtyymxJF3ryidMesV/C/b5mBUrjUco2g3SOrY5CZiMIrlRr4zR66MoUtdfj1GfFvVedCXDOegH3U6hrbCXbr0ivk0qZu/8SQeElhHY/RYc8p1bVKOv4tptUPu01qdKl+tpesIY00dMC4+dP/37K1PDP1bP4+SCWn3XQf9X13y7QEjjc+OnfpKJaptzU/s9QkYtcAIhALiTLO2USc+U9V7/juoCWojTd93XmqXLJGeRIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UxJB9hScs/uOxSoorp+zDEhMLQv8XAbjW4Ou72P628k=;
 b=KMaBGruzHN9u7/WXBYviW6um/HdXHAe2likQd8Q0VnTEDMlse+4OSM5klGm0Zd/KLMZuE+l0fIWs94wcMu7HYeNMRpcgM7wXOGQiduPoxESQNjTFsWeLepxYjUyrt+caarGXgM3IvdzeQ+V8rndwdM59ajU51G+YtakKbyfnc0+p2piWvGC+vQegoJV/jxv9Su5xmzVcgP0I/eEQXCbgHQSQL36qD+S9iol5jmO+m1HjT2KEP70Q5nrVTQwv1yT9+dhIlcnG4HlLEUmhP2Tp9OeXnkSKCz5DPeq4mmu/fSBSjwjFkqB2WV0XdAa+Wz8rhPkcaB9j5Z1ItuhxU3z9Dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AS8PR04MB8280.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 15:27:25 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9587.010; Tue, 10 Feb 2026
 15:27:25 +0000
Date: Tue, 10 Feb 2026 10:27:16 -0500
From: Frank Li <Frank.li@nxp.com>
To: Binbin Zhou <zhoubb.aaron@gmail.com>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org,
	Xiaochuang Mao <maoxiaochuan@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
	devicetree@vger.kernel.org, Keguang Zhang <keguang.zhang@gmail.com>,
	linux-mips@vger.kernel.org, jeffbai@aosc.io
Subject: Re: [PATCH v2 4/4] dmaengine: loongson: New driver for the Loongson
 Multi-Channel DMA controller
Message-ID: <aYtOVFsoDg2m6yhi@lizhi-Precision-Tower-5810>
References: <cover.1770605931.git.zhoubinbin@loongson.cn>
 <a0eac5b7ba0bcced9664ff64349e563da3d031b3.1770605931.git.zhoubinbin@loongson.cn>
 <aYoTtQ01VGXEW2Fu@lizhi-Precision-Tower-5810>
 <CAMpQs4JwDSWCXYFiPXNf1pKbYqUK+9hLXYsQsG+rQQqi_eZJwQ@mail.gmail.com>
 <CAMpQs4KSyj3HFrY0Qn_ZByekVWu3-re__6TAE=nU+uC_VfKB8w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMpQs4KSyj3HFrY0Qn_ZByekVWu3-re__6TAE=nU+uC_VfKB8w@mail.gmail.com>
X-ClientProxiedBy: PH0PR07CA0046.namprd07.prod.outlook.com
 (2603:10b6:510:e::21) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AS8PR04MB8280:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a9a0fcb-326e-4b67-096a-08de68b8e46f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|52116014|376014|7416014|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?alN2dnZNN0tEZ3NoRVFESFJoSGR1dmVFUHgxMkJwYVRydldXQXNTQ3p5azdZ?=
 =?utf-8?B?MS8yLzZIMzhORENHb3lLRDlaaSt5bnhBTW5IS25TcGRmQmxsdWRqZ3VEVmcz?=
 =?utf-8?B?c0N3bVFtZ1hKazFHa1lOT3NhOWxFTVQxR1M5MGhMWnJVdTBsVmNzc3dsUEIy?=
 =?utf-8?B?ektMd2VvT2NycGdEV1B3Y0F3NkNxY0U4bGRPSFlzVmJTUjRnYUNIeVlpOTUr?=
 =?utf-8?B?SHlxNEhOc1dCRW9uSndtRDN5NUN4MVU3bjgvdmtucFdjTUU1clVOUVZpYXlX?=
 =?utf-8?B?YnJWMnJJcXpPUWtSRVdtdVhjRzhSWjBPSG1kTnFCOGdPejJ0NmE5ajBVR2pW?=
 =?utf-8?B?L3ZRNHEvUnBtZ3ZjbEVqaTgvTklSZWV4bDNkNW90eGI2cDNrSGRwZ0tQcjQ2?=
 =?utf-8?B?ZnBTbTV3SlEyMkQ1T2F0QlFNTm01MDdqTjcwK2MyQzJVSWtnOHJQSWlZemtt?=
 =?utf-8?B?V1VjeWg5L3hRZVRrRlpWOTMycWNIVk54SDJzcjhSOERVVlVXN0VxTjl4L1N4?=
 =?utf-8?B?SVNJbURNUzY0ekdxWXh4cUpKR2JTK2QvajFKTXZlWWg4K1JRMjk5bWJTSjZq?=
 =?utf-8?B?Z0RiZUVsUXM4aTk1UlJBSmkvKy9NSDliaHZCb0cyS3FKVWUrR1VKb0tqejNj?=
 =?utf-8?B?NnNGMS82Sy9YQytQcVVtcTZSQW51aDhHWTdRUS9zcS91VWlRNzBXbEdIbUp1?=
 =?utf-8?B?c2c0L3Y1US9zRjV3cm5uNmRDL3JPMm1vREIxekFQZWo3Myt1NEhxKy9FNGpQ?=
 =?utf-8?B?bnNoN2tyeTFabFJQR3hCZmFDSm9raGNza1FvRG92VjMyM3FKa3VCRmZ6cmtm?=
 =?utf-8?B?MFhOaHJKUHJERURZYml0OUJoUkkwc215WHhmTHYzeXVZd0c2YVZhMVBGQVpX?=
 =?utf-8?B?SXFHazVhRnlPMnFxTmg2RDNxOGVuOEZpQVIwdE5jRkFhTVFKdzVzbitCdDBa?=
 =?utf-8?B?VlF3V3NmZzNRZEZxZXU3MjVMYS82bDZaRnhPajBsRVd5L2duRkJyZlpKSjJi?=
 =?utf-8?B?TEJkSHNib1FPTHFIRFJnVjZsUHlsMk9NSFY0OE82a2J4K2Z3ZEI3TW9kNzRo?=
 =?utf-8?B?SFdQRE9lYTZacFN5dDVCRHFuczEzWmdKUWtJazZnWHNGcmVqWWR0elNBZnR6?=
 =?utf-8?B?TmtLd3NobE9QRS94MmhQdDJ0Zyt5YzQ4YlpLeUt2UE9HZUtXRDFYUUxiN1E2?=
 =?utf-8?B?N1NLYnR1a0JvR2c1S29KOHNHd3cwZzhvT1BKQkxFYURpUTdqd2g4OWhzelBG?=
 =?utf-8?B?VzNiUE03RU1zQVEzTG5rVms1Sk00ZzhVNjg3QzdqV1N4OXhaN3JNRldQRDRI?=
 =?utf-8?B?cDhzeVhIemZYUXBxOTlhSVRWb3V2UVIxbnluc1FiTi9sbkR6aE92NHg1YUpZ?=
 =?utf-8?B?YkNZUnpmRW5saU1iTVZDMjdLU1BzdHg1SnRsdHBLM2ppTmE2Q1BhTUd2VS91?=
 =?utf-8?B?djluaXBlS2Vnb21XM0tzSHU0WVAwQVYzTC9ZOEN0NUEyWWFYSzVkeDRvMUV6?=
 =?utf-8?B?TDNjcWJqMkIyNFRmdkExOGFlTGYrUyt1NE9OTllRSHpRYW5XOWEyNCtieWVn?=
 =?utf-8?B?MlY0Q05sZ25QRzNqdHo4RHJ2V0s1T04zOWU5ZkRwK2dwRjZPVk1ESFFZVmJQ?=
 =?utf-8?B?UlhscXR3enQ1MkNHOHBuN0tZNVM2RHlTQXplNVd0MkI5VFRIKzFqcENEMTRE?=
 =?utf-8?B?UnBEcGxKNWpic1pMc3huNUsvRkQvck9HUEVhYU1uU3pGTTFpcGJnd3E5QWt6?=
 =?utf-8?B?YnpLcGIwekdyZEUvUE9mSitMT0p1VFlYcjlxSTBMN1FVdGp3S1QwRlUvU2pr?=
 =?utf-8?B?V1B2c2ZBV0RmcVRES24rQm5vTk9zcitQY3E0d0NaMHB3TFMyTng5RURFRXg4?=
 =?utf-8?B?VFNjdXNwYktlKy9aWjNXdml1cldXWFZ3Y29TeU1YUXVLOXoycmN5cXZlQlJ1?=
 =?utf-8?B?SGg3ZWpaQ3A4bTcyTjAwaU9qODBlK1h2K0Rudko2Q1FJa3lKUjBPUzFYOFBZ?=
 =?utf-8?B?Q3RnNUYyaGFndTN5a2c1WHJ0cElTTzc4dDhqYXlkek9yeDRJZDdjWnQ4L1dx?=
 =?utf-8?B?VnYrTVRrVlRPd24vYVNMeU9nclJrSExKYWtla09LYnZ3dzBLQVEycmkrNks1?=
 =?utf-8?B?Q290MFQxaXBwNFNiMkxLdWU5OHJWYjZkK0NFeHQwNUZibDZ3bFM0NWRkYlQv?=
 =?utf-8?Q?I1d77uxc4u+YwiZej8+qR3g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(52116014)(376014)(7416014)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VEtNVC9VYVY1NmUzeXhORnNMWGM2QjhyZ1J1cmtRYkFDU1BhTFR1SUVrN2R2?=
 =?utf-8?B?TVNGU3pFekVhbllwcUdmUmIvLzVlNFRKcFBHOGI4eE51ODlzeVVmY2RiYjJx?=
 =?utf-8?B?RGNIWDJ6S1RYaFA5dlN6WFBqSnU2SmNadWJ5aGVuYXBoeExrZDROcXNNUEVo?=
 =?utf-8?B?bzBRcVRiQ2J1OFNxR3orMUpvckdYdnZLNXlLaWZxZ1U2TjdGTENqR2lnSU1H?=
 =?utf-8?B?bkUrb2MvV0ZDMUxUZ0VtUVMwdVZPQVlGWXE3QzRSUkNSaUtGcTBINS9scm1P?=
 =?utf-8?B?dmsvcXJaREgzM2xLb0RxWnNVYU9Yd1FOTUNHN2hQRThKTEZzRno1NXFtb3BN?=
 =?utf-8?B?TStwMzhoMHlIeCtCVVFPbmhtRSt6dWZsNXBwUWdIeXRQMnBYaVdqdCtjUHc5?=
 =?utf-8?B?YmZLQ1FyYU4zZmtwN2Fwc3B4RkhmS044bHNPb1ZpaUtsdG81Skpkamh1b042?=
 =?utf-8?B?bTZPTDZwakwwT0FQUUpWUFY5SWRLNkJIRkVUSFdiRmp4RmxBcFV4QkZSUUFa?=
 =?utf-8?B?b2FhV3RDNnpzMDQ5aGNlSnlSekdiQTlQY2JJMDE5Qjk2aHducnRJWkgrMjlq?=
 =?utf-8?B?QU5ha1FTenZ1TE9mTjFSVmROY3lhT3BHRnZ3VXNEMVNqNkI5TTkvNE4rMWZV?=
 =?utf-8?B?RUw5WFlldTJTSXhzVTBNK1JZZHgzVkYrSDZnT3c3QjVjUDd5RXBkMS9EZGc3?=
 =?utf-8?B?eFRnQllnZ1Y5ZEo1UnVyZi9nWTkrUGNVRi9obnVHUzUxaWxRdjNYSWhnREFW?=
 =?utf-8?B?LzJVckJ5ZjArWmZ3YnhkWndkSytXVkxJczZzZmVxV2ppWmdZTmVaYlphZzdj?=
 =?utf-8?B?QmF3UnBLQUVJK2RRaDkrYk1Teml2QkpBZHNDSDlCMXlwc1dlZGxUV2lkVmtC?=
 =?utf-8?B?cUZpaUhXRTRQdzAwVG1GdXhmVU1FVUQxbHUyS3Z2K1FHc1JpTEdobGZhUFoy?=
 =?utf-8?B?bS9GNWNlemE0emNNWGFYdWlJUnl4eCtZRXdsREZIczRQMFJWZHNrVjN5WFRm?=
 =?utf-8?B?RHdiOXNXYklTdG0zWWN3L3NrUkFDVldFMERRQk53Qmcva3F6aFNmYnAxT3Zt?=
 =?utf-8?B?QVExUWZ4TzlUTXRqd0c5S0dIcnRRdHVHeVRZd05nellyN3I4Uk9JaGhwYzNq?=
 =?utf-8?B?bDdaSEozeGJrcUVWcGRnRjJlVzhTcEFmTUNSbVczQzBVa1I2MjFhdHpjcER1?=
 =?utf-8?B?c1ZaYnhSOGhUamw5TUtDdHE5OGhBeWFzZkZrcXBKNVBDQjdTY3hSZEhWdk4x?=
 =?utf-8?B?OGZLRFFncHhaa2dSYVdNbXg0SFZRdklDSk1vaTFESDdSMkxqVFhpaHRqVC9h?=
 =?utf-8?B?RGR6elROZVhsUUhSblBHTEwvZVVMN3k3cTdldUtrdmJZTVhnZlBheDZFeGk0?=
 =?utf-8?B?YkZ6b2ViMnJza0JtZGNmMWN6KzVFbkJ1MEx1N2tZc2x3NTNaWithb05kb2w4?=
 =?utf-8?B?MEpvVlR2OUx0NjJCVEVuZHhuSUNWYkZJeWhjZG1DRUlYSm80VElLY2cvcmFU?=
 =?utf-8?B?K2dKQi9TbkVRSEdST3BnSDd1WWVROFd3eFVOb3JQNmhGRXNJMkdscWFTNjAz?=
 =?utf-8?B?MW11MzNiUk05OVhWMUxUWXcrdHYzWFJIS3dBWWlKQjM0S1J4VDJaNjcvOXBH?=
 =?utf-8?B?NzVucEdDZ1FFYjRib21KcFBHZEJHcUZ1NXA4Q29LVlMvcFN5V3ZtcUVTS3ho?=
 =?utf-8?B?RXUwdTBPb2lhOUl3emFPa1BLSFRSNU1EOC80USs3aGhKbVVqS212eFhMamNI?=
 =?utf-8?B?V1J4R3BxbFJqSmU3YlJYYzVDMjBSWXNwSDZ5eGJ6K3RXMldOMEhCUVhjbmVS?=
 =?utf-8?B?L2lSVVhQTVRZZzN3T2MyYmprbThDNjV6blgxbjZyQ1FVVUxuSzlWZjY2RzZM?=
 =?utf-8?B?QnlzZGsra1h2MmJhS3pkTkcvclBUak96cHBrczBPRzdDbnRORkZBNC8xOE4x?=
 =?utf-8?B?czVhbXZ0NFB1akdkc1IrTTdqNkVwd01mM1d0SjJIRldSTVJjR0V2MGJ5V1ly?=
 =?utf-8?B?d0NTQWcvTUF1K2d3WG9rUEt4bjIvZitsZGpkaC9RNVczYVNDR1ZIOHpEMFZS?=
 =?utf-8?B?T3l2NGhTdEs5c0lCcER1Szdzek5zU2MwcUpwM3N3cG45Q0ZTVjEzOGV0Nnc2?=
 =?utf-8?B?em04T2RJb253L3JDd3FyeTQ3VUdnajFnVkdnc2p2QmcySWtmZkhxdVZIdDgy?=
 =?utf-8?B?YURGSlc2OVQweCs1MldWU3BYMEJSZ1VYb2RxTS9Qa1JVb3F4cjdtdUIva3VO?=
 =?utf-8?B?MXNnTXU5bGk1ZGJTdHVZOWNzaTlPT1ZyRTAwb0NGeS9CcGlZT21nNEY5VFpj?=
 =?utf-8?Q?017sJaqthBfPoHRANw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a9a0fcb-326e-4b67-096a-08de68b8e46f
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 15:27:25.1855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EZPcHybVUFCJB6BoYfR5Yv14HLs4XZ8fAvZf1B6boo9QQEWzREf42Qg+g7XgHKuqzgbR3uJnhSD5AISZGfwwTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8280
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8879-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[loongson.cn,kernel.org,vger.kernel.org,xen0n.name,lists.linux.dev,gmail.com,aosc.io];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,loongson.cn:email,nxp.com:email,nxp.com:dkim]
X-Rspamd-Queue-Id: E561311C746
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 08:02:21PM +0800, Binbin Zhou wrote:
> Hi Frank:
>
> On Tue, Feb 10, 2026 at 3:41 PM Binbin Zhou <zhoubb.aaron@gmail.com> wrote:
> >
> > Hi Frank:
> >
> > Thanks for your reply.
> >
> > On Tue, Feb 10, 2026 at 1:05 AM Frank Li <Frank.li@nxp.com> wrote:
> > >
> > > On Mon, Feb 09, 2026 at 11:04:55AM +0800, Binbin Zhou wrote:
> > > > This DMA controller appears in Loongson-2K0300 and Loongson-2K3000.
> > > >
> > > > It is a chain multi-channel controller that enables data transfers from
> > > > memory to memory, device to memory, and memory to device, as well as
> > > > channel prioritization configurable through the channel configuration
> > > > registers.
> > > >
> > > > In addition, there are slight differences between Loongson-2K0300 and
> > > > Loongson-2K3000, such as channel register offsets and the number of
> > > > channels.
> > > >
> > > > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > > > ---
> > > >  MAINTAINERS                                  |   1 +
> > > >  drivers/dma/loongson/Kconfig                 |  10 +
> > > >  drivers/dma/loongson/Makefile                |   1 +
> > > >  drivers/dma/loongson/loongson2-apb-cmc-dma.c | 736 +++++++++++++++++++
> > > >  4 files changed, 748 insertions(+)
> > > >  create mode 100644 drivers/dma/loongson/loongson2-apb-cmc-dma.c
> > > >
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > index d3cb541aee2a..61a39070d7a0 100644
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -14778,6 +14778,7 @@ L:    dmaengine@vger.kernel.org
> > > >  S:   Maintained
> > > >  F:   Documentation/devicetree/bindings/dma/loongson,ls2k0300-dma.yaml
> > > >  F:   Documentation/devicetree/bindings/dma/loongson,ls2x-apbdma.yaml
> > > > +F:   drivers/dma/loongson/loongson2-apb-cmc-dma.c
> > > >  F:   drivers/dma/loongson/loongson2-apb-dma.c
> > > >
> > > >  LOONGSON LS2X I2C DRIVER
> > > > diff --git a/drivers/dma/loongson/Kconfig b/drivers/dma/loongson/Kconfig
> > > > index 9dbdaef5a59f..28b3daeed4e3 100644
> > > > --- a/drivers/dma/loongson/Kconfig
> > > > +++ b/drivers/dma/loongson/Kconfig
> > > > @@ -25,4 +25,14 @@ config LOONGSON2_APB_DMA
> > > >         This DMA controller transfers data from memory to peripheral fifo.
> > > >         It does not support memory to memory data transfer.
> > > >
> > > > +config LOONGSON2_APB_CMC_DMA
> > > > +     tristate "Loongson2 Chain Multi-Channel DMA support"
> > > > +     select DMA_ENGINE
> > > > +     select DMA_VIRTUAL_CHANNELS
> > > > +     help
> > > > +       Support for the Loongson Chain Multi-Channel DMA controller driver.
> > > > +       It is discovered on the Loongson-2K chip (Loongson-2K0300/Loongson-2K3000),
> > > > +       which has 4/8 channels internally, enabling bidirectional data transfer
> > > > +       between devices and memory.
> > > > +
> > > >  endif
> > > > diff --git a/drivers/dma/loongson/Makefile b/drivers/dma/loongson/Makefile
> > > > index 6cdd08065e92..48c19781e729 100644
> > > > --- a/drivers/dma/loongson/Makefile
> > > > +++ b/drivers/dma/loongson/Makefile
> > > > @@ -1,3 +1,4 @@
> > > >  # SPDX-License-Identifier: GPL-2.0-only
> > > >  obj-$(CONFIG_LOONGSON1_APB_DMA) += loongson1-apb-dma.o
> > > >  obj-$(CONFIG_LOONGSON2_APB_DMA) += loongson2-apb-dma.o
> > > > +obj-$(CONFIG_LOONGSON2_APB_CMC_DMA) += loongson2-apb-cmc-dma.o
> > > > diff --git a/drivers/dma/loongson/loongson2-apb-cmc-dma.c b/drivers/dma/loongson/loongson2-apb-cmc-dma.c
> > > > new file mode 100644
> > > > index 000000000000..f598ad095686
> > > > --- /dev/null
> > > > +++ b/drivers/dma/loongson/loongson2-apb-cmc-dma.c
> > > > @@ -0,0 +1,736 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > > +/*
> > > > + * Looongson-2 Multi-Channel DMA Controller driver
> > > > + *
> > > > + * Copyright (C) 2024-2026 Loongson Technology Corporation Limited
> > > > + */
> > > > +
> > > > +#include <linux/acpi.h>
> > > > +#include <linux/acpi_dma.h>
> > > > +#include <linux/bitfield.h>
> > > > +#include <linux/clk.h>
> > > > +#include <linux/dma-mapping.h>
> > > > +#include <linux/dmapool.h>
> > > > +#include <linux/interrupt.h>
> > > > +#include <linux/io.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/of.h>
> > > > +#include <linux/of_dma.h>
> > > > +#include <linux/platform_device.h>
> > > > +#include <linux/slab.h>
> > > > +
> > > > +#include "../dmaengine.h"
> > > > +#include "../virt-dma.h"
> > > > +
> > > > +#define LOONGSON2_CMCDMA_ISR         0x0     /* DMA Interrupt Status Register */
> > > > +#define LOONGSON2_CMCDMA_IFCR                0x4     /* DMA Interrupt Flag Clear Register */
> > > > +#define LOONGSON2_CMCDMA_CCR         0x8     /* DMA Channel Configuration Register */
> > > > +#define LOONGSON2_CMCDMA_CNDTR               0xc     /* DMA Channel Transmit Count Register */
> > > > +#define LOONGSON2_CMCDMA_CPAR                0x10    /* DMA Channel Peripheral Address Register */
> > > > +#define LOONGSON2_CMCDMA_CMAR                0x14    /* DMA Channel Memory Address Register */
> > > > +
> > > > +/* Bitfields of DMA interrupt status register */
> > > > +#define LOONGSON2_CMCDMA_TCI         BIT(1) /* Transfer Complete Interrupt */
> > > > +#define LOONGSON2_CMCDMA_HTI         BIT(2) /* Half Transfer Interrupt */
> > > > +#define LOONGSON2_CMCDMA_TEI         BIT(3) /* Transfer Error Interrupt */
> > > > +
> > > > +#define LOONGSON2_CMCDMA_MASKI               \
> > > > +     (LOONGSON2_CMCDMA_TCI | LOONGSON2_CMCDMA_HTI | LOONGSON2_CMCDMA_TEI)
> > > > +
> > > > +/* Bitfields of DMA channel x Configuration Register */
> > > > +#define LOONGSON2_CMCDMA_CCR_EN              BIT(0) /* Stream Enable */
> > > > +#define LOONGSON2_CMCDMA_CCR_TCIE    BIT(1) /* Transfer Complete Interrupt Enable */
> > > > +#define LOONGSON2_CMCDMA_CCR_HTIE    BIT(2) /* Half Transfer Complete Interrupt Enable */
> > > > +#define LOONGSON2_CMCDMA_CCR_TEIE    BIT(3) /* Transfer Error Interrupt Enable */
> > > > +#define LOONGSON2_CMCDMA_CCR_DIR     BIT(4) /* Data Transfer Direction */
> > > > +#define LOONGSON2_CMCDMA_CCR_CIRC    BIT(5) /* Circular mode */
> > > > +#define LOONGSON2_CMCDMA_CCR_PINC    BIT(6) /* Peripheral increment mode */
> > > > +#define LOONGSON2_CMCDMA_CCR_MINC    BIT(7) /* Memory increment mode */
> > > > +#define LOONGSON2_CMCDMA_CCR_PSIZE_MASK      GENMASK(9, 8)
> > > > +#define LOONGSON2_CMCDMA_CCR_MSIZE_MASK      GENMASK(11, 10)
> > > > +#define LOONGSON2_CMCDMA_CCR_PL_MASK GENMASK(13, 12)
> > > > +#define LOONGSON2_CMCDMA_CCR_M2M     BIT(14)
> > > > +
> > > > +#define LOONGSON2_CMCDMA_CCR_CFG_MASK        \
> > > > +     (LOONGSON2_CMCDMA_CCR_PINC | LOONGSON2_CMCDMA_CCR_MINC | LOONGSON2_CMCDMA_CCR_PL_MASK)
> > > > +
> > > > +#define LOONGSON2_CMCDMA_CCR_IRQ_MASK        \
> > > > +     (LOONGSON2_CMCDMA_CCR_TCIE | LOONGSON2_CMCDMA_CCR_HTIE | LOONGSON2_CMCDMA_CCR_TEIE)
> > > > +
> > > > +#define LOONGSON2_CMCDMA_STREAM_MASK \
> > > > +     (LOONGSON2_CMCDMA_CCR_CFG_MASK | LOONGSON2_CMCDMA_CCR_IRQ_MASK)
> > > > +
> > > > +#define LOONGSON2_CMCDMA_BUSWIDTHS   (BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) | \
> > > > +                                      BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) | \
> > > > +                                      BIT(DMA_SLAVE_BUSWIDTH_4_BYTES))
> > > > +
> > > > +enum loongson2_cmc_dma_width {
> > > > +     LOONGSON2_CMCDMA_BYTE,
> > > > +     LOONGSON2_CMCDMA_HALF_WORD,
> > > > +     LOONGSON2_CMCDMA_WORD,
> > > > +};
> > > > +
> > > > +struct loongson2_cmc_dma_chan_reg {
> > > > +     u32 ccr;
> > > > +     u32 cndtr;
> > > > +     u32 cpar;
> > > > +     u32 cmar;
> > > > +};
> > > > +
> > > > +struct loongson2_cmc_dma_sg_req {
> > > > +     u32 len;
> > > > +     struct loongson2_cmc_dma_chan_reg chan_reg;
> > > > +};
> > > > +
> > > > +struct loongson2_cmc_dma_desc {
> > > > +     struct virt_dma_desc vdesc;
> > > > +     bool cyclic;
> > > > +     u32 num_sgs;
> > > > +     struct loongson2_cmc_dma_sg_req sg_req[] __counted_by(num_sgs);
> > > > +};
> > > > +
> > > > +struct loongson2_cmc_dma_chan {
> > > > +     struct virt_dma_chan vchan;
> > > > +     struct dma_slave_config dma_sconfig;
> > > > +     struct loongson2_cmc_dma_desc *desc;
> > > > +     u32 id;
> > > > +     u32 irq;
> > > > +     u32 next_sg;
> > > > +     struct loongson2_cmc_dma_chan_reg chan_reg;
> > > > +};
> > > > +
> > > > +struct loongson2_cmc_dma_config {
> > > > +     u32 max_channels;
> > > > +     u32 chan_reg_offset;
> > > > +};
> > > > +
> > > > +struct loongson2_cmc_dma_dev {
> > > > +     struct dma_device ddev;
> > > > +     struct clk *dma_clk;
> > > > +     void __iomem *base;
> > > > +     u32 nr_channels;
> > > > +     u32 chan_reg_offset;
> > > > +     struct loongson2_cmc_dma_chan chan[] __counted_by(nr_channels);
> > > > +};
> > > > +
> > > > +static const struct loongson2_cmc_dma_config ls2k0300_cmc_dma_config = {
> > > > +     .max_channels = 8,
> > > > +     .chan_reg_offset = 0x14,
> > > > +};
> > > > +
> > > > +static const struct loongson2_cmc_dma_config ls2k3000_cmc_dma_config = {
> > > > +     .max_channels = 4,
> > > > +     .chan_reg_offset = 0x18,
> > > > +};
> > > > +
> > > > +static struct loongson2_cmc_dma_dev *lmdma_get_dev(struct loongson2_cmc_dma_chan *lchan)
> > > > +{
> > > > +     return container_of(lchan->vchan.chan.device, struct loongson2_cmc_dma_dev, ddev);
> > > > +}
> > > > +
> > > > +static struct loongson2_cmc_dma_chan *to_lmdma_chan(struct dma_chan *chan)
> > > > +{
> > > > +     return container_of(chan, struct loongson2_cmc_dma_chan, vchan.chan);
> > > > +}
> > > > +
> > > > +static struct loongson2_cmc_dma_desc *to_lmdma_desc(struct virt_dma_desc *vdesc)
> > > > +{
> > > > +     return container_of(vdesc, struct loongson2_cmc_dma_desc, vdesc);
> > > > +}
> > > > +
> > > > +static struct device *chan2dev(struct loongson2_cmc_dma_chan *lchan)
> > > > +{
> > > > +     return &lchan->vchan.chan.dev->device;
> > > > +}
> > > > +
> > > > +static u32 loongson2_cmc_dma_read(struct loongson2_cmc_dma_dev *lddev, u32 reg, u32 id)
> > > > +{
> > > > +     return readl(lddev->base + (reg + lddev->chan_reg_offset * id));
> > > > +}
> > > > +
> > > > +static void loongson2_cmc_dma_write(struct loongson2_cmc_dma_dev *lddev, u32 reg, u32 id, u32 val)
> > > > +{
> > > > +     writel(val, lddev->base + (reg + lddev->chan_reg_offset * id));
> > > > +}
> > > > +
> > > > +static int loongson2_cmc_dma_get_width(struct loongson2_cmc_dma_chan *lchan,
> > > > +                                    enum dma_slave_buswidth width)
> > > > +{
> > > > +     switch (width) {
> > > > +     case DMA_SLAVE_BUSWIDTH_1_BYTE:
> > > > +             return LOONGSON2_CMCDMA_BYTE;
> > > > +     case DMA_SLAVE_BUSWIDTH_2_BYTES:
> > > > +             return LOONGSON2_CMCDMA_HALF_WORD;
> > > > +     case DMA_SLAVE_BUSWIDTH_4_BYTES:
> > > > +             return LOONGSON2_CMCDMA_WORD;
> > >
> > > is ffs() helper in case your hardware support more buswidth in future?
> >
> > It seems there's no need for us to do this.
> > The data width setting bit in the DMA channel configuration register
> > only has two bits (LOONGSON2_CMCDMA_CCR_PSIZE_MASK). The bitmask
> > values are: 8-bit/16-bit/32-bit/reserved.
>
> Sorry, I checked again, the ffs() helper can make the code cleaner:
>
> static int loongson2_cmc_dma_get_width(enum dma_slave_buswidth width)
> {
>         switch (width) {
>         case DMA_SLAVE_BUSWIDTH_1_BYTE:
>         case DMA_SLAVE_BUSWIDTH_2_BYTES:
>         case DMA_SLAVE_BUSWIDTH_4_BYTES:
>                 return ffs(width) - 1;
>         default:
>                 return -EINVAL;
>         }
> }

if (width >= DMA_SLAVE_BUSWIDTH_4_BYTES)
	return -EINVAL;

return ffs(width) - 1;

>
> And the enum loongson2_cmc_dma_width{ } can be dropped.
>
> > >
> > > > +     default:
> > > > +             dev_err(chan2dev(lchan), "Dma bus width not supported\n");
> > > > +             return -EINVAL;
> > > > +     }
> > > > +}
> > > > +
...
> > > > +     if (status & LOONGSON2_CMCDMA_TCI)
> > > > +             loongson2_cmc_dma_handle_chan_done(lchan);
> > > > +
> > > > +     if (status & LOONGSON2_CMCDMA_HTI)
> > > > +             loongson2_cmc_dma_irq_clear(lchan, LOONGSON2_CMCDMA_HTI);
> > > > +
> > > > +     if (status & LOONGSON2_CMCDMA_TEI)
> > > > +             dev_err(chan2dev(lchan), "DMA Transform Error\n");
> > > > +
> > > > +     loongson2_cmc_dma_irq_clear(lchan, status);
> > >
> > > irq clear should before loongson2_cmc_dma_handle_chan_done() incase you
> > > missed irq, if loongson2_cmc_dma_handle_chan_done() trigger new irq before
> > > your call irq_cler().
>
> Yes, this part should be refracted, how about the following code:
>
>         spin_lock(&lchan->vchan.lock);
>
>         ccr = loongson2_cmc_dma_read(lddev, LOONGSON2_CMCDMA_CCR, lchan->id);
>         ists = loongson2_cmc_dma_read(lddev, LOONGSON2_CMCDMA_ISR, 0);
>         status = (ists >> (4 * lchan->id)) & LOONGSON2_CMCDMA_MASKI;
>
>         if (status & LOONGSON2_CMCDMA_TCI) {
>                 loongson2_cmc_dma_irq_clear(lchan, LOONGSON2_CMCDMA_TCI);

if status is w1c, you can clean it unconditional.

>                 if (ccr & LOONGSON2_CMCDMA_CCR_TCIE)

Not sure your hardware, generally irq status register will not set if
enable bit have not set.

>                         loongson2_cmc_dma_handle_chan_done(lchan);
>                 status &= ~LOONGSON2_CMCDMA_TCI;
>         }
>
>         if (status & LOONGSON2_CMCDMA_HTI) {
>                 loongson2_cmc_dma_irq_clear(lchan, LOONGSON2_CMCDMA_HTI);
>                 status &= ~LOONGSON2_CMCDMA_HTI;
>         }
>
>         if (status & LOONGSON2_CMCDMA_TEI) {
>                 loongson2_cmc_dma_irq_clear(lchan, LOONGSON2_CMCDMA_HTI);
>                 dev_err(chan2dev(lchan), "DMA Transform Error\n");
>                 if (!(ccr & LOONGSON2_CMCDMA_CCR_EN))
>                         dev_err(chan2dev(lchan), "chan disabled by HW\n");
>         }
>
>         spin_unlock(&lchan->vchan.lock);
>
> > >
> > > > +
> > > > +     spin_unlock(&lchan->vchan.lock);
> > > > +
> > > > +     return IRQ_HANDLED;
> > > > +}
> > > > +
> > > > +static void loongson2_cmc_dma_issue_pending(struct dma_chan *chan)
> > > > +{
> > > > +     struct loongson2_cmc_dma_chan *lchan = to_lmdma_chan(chan);
> > > > +     unsigned long flags;
> > > > +
> > > > +     spin_lock_irqsave(&lchan->vchan.lock, flags);
> > > > +     if (vchan_issue_pending(&lchan->vchan) && !lchan->desc) {
> > > > +             dev_dbg(chan2dev(lchan), "vchan %pK: issued\n", &lchan->vchan);
> > > > +             loongson2_cmc_dma_start_transfer(lchan);
> > > > +     }
> > > > +     spin_unlock_irqrestore(&lchan->vchan.lock, flags);
> > > > +}
> > > > +
...
> > > > +static struct dma_async_tx_descriptor *
> > > > +loongson2_cmc_dma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl, u32 sg_len,
> > > > +                             enum dma_transfer_direction direction,
> > > > +                             unsigned long flags, void *context)
> > > > +{
> > > > +     struct loongson2_cmc_dma_chan *lchan = to_lmdma_chan(chan);
> > > > +     struct loongson2_cmc_dma_desc *desc;
> > > > +     enum dma_slave_buswidth buswidth;
> > > > +     struct scatterlist *sg;
> > > > +     u32 num_items, i;
> > > > +     int ret;
> > > > +
> > > > +     desc = kzalloc(struct_size(desc, sg_req, sg_len), GFP_NOWAIT);
> > > > +     if (!desc)
> > > > +             return NULL;
> > > > +
> > > > +     for_each_sg(sgl, sg, sg_len, i) {
> > > > +             ret = loongson2_cmc_dma_set_xfer_param(lchan, direction, &buswidth, sg_dma_len(sg));
> > > > +             if (ret)
> > > > +                     return NULL;
> > > > +
> > > > +             desc->sg_req[i].len = sg_dma_len(sg);
> > > > +
> > > > +             num_items = desc->sg_req[i].len / buswidth;
> > > > +             if (num_items >= SZ_64K) {
> > > > +                     dev_err(chan2dev(lchan), "Number of items not supported\n");
> > > > +                     kfree(desc);
> > > > +                     return NULL;
> > >
> > > if use sg_nents_for_dma(), you can use multi sg to trasfer more than 64K
> > > data.
> >
> > Sorry, are you referring to sg_nents_for_len()?
> > 64K is a hardware limitation of the controller, so it seems impossible
> > to resolve it using that function, right?

you can use multi sg_req to implement it, which max 64K.

	sg_reqp[i + 0] -> 1st 64k
	sg_reqp[i + 1] -> 2nd 64k
	...

Only need allocate more at kzalloc with sg_nents_for_len(), in stead of
sg_len.

Frank


> >
> > >
> > > > +             }
> > > > +             desc->sg_req[i].chan_reg.ccr = lchan->chan_reg.ccr;
> > > > +             desc->sg_req[i].chan_reg.cpar = lchan->chan_reg.cpar;
> > > > +             desc->sg_req[i].chan_reg.cmar = sg_dma_address(sg);
> > > > +             desc->sg_req[i].chan_reg.cndtr = num_items;
> > > > +     }
> > > > +
> > > > +     desc->num_sgs = sg_len;
> > > > +     desc->cyclic = false;
> > > > +
> > > > +     return vchan_tx_prep(&lchan->vchan, &desc->vdesc, flags);
> > > > +}
> > > > +
> > > > +static struct dma_async_tx_descriptor *
> > > > +loongson2_cmc_dma_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
> > > > +                               size_t period_len, enum dma_transfer_direction direction,
> > > > +                               unsigned long flags)
> > > > +{
> > > > +     struct loongson2_cmc_dma_chan *lchan = to_lmdma_chan(chan);
> > > > +     struct loongson2_cmc_dma_desc *desc;
> > > > +     enum dma_slave_buswidth buswidth;
> > > > +     u32 num_periods, num_items, i;
> > > > +     int ret;
> > > > +
> > > > +     if (unlikely(buf_len % period_len))
> > > > +             return NULL;
> > > > +
> > > > +     ret = loongson2_cmc_dma_set_xfer_param(lchan, direction, &buswidth, period_len);
> > > > +     if (ret)
> > > > +             return NULL;
> > > > +
> > > > +     num_items = period_len / buswidth;
> > > > +     if (num_items >= SZ_64K) {
> > > > +             dev_err(chan2dev(lchan), "Number of items not supported\n");
> > > > +             return NULL;
> > > > +     }
> > > > +
> > > > +     /* Enable Circular mode */
> > > > +     if (buf_len == period_len)
> > > > +             lchan->chan_reg.ccr |= LOONGSON2_CMCDMA_CCR_CIRC;
> > > > +
> > > > +     num_periods = buf_len / period_len;
> > > > +     desc = kzalloc(struct_size(desc, sg_req, num_periods), GFP_NOWAIT);
> > > > +     if (!desc)
> > > > +             return NULL;
> > > > +
> > > > +     for (i = 0; i < num_periods; i++) {
> > > > +             desc->sg_req[i].len = period_len;
> > > > +             desc->sg_req[i].chan_reg.ccr = lchan->chan_reg.ccr;
> > > > +             desc->sg_req[i].chan_reg.cpar = lchan->chan_reg.cpar;
> > > > +             desc->sg_req[i].chan_reg.cmar = buf_addr;
> > > > +             desc->sg_req[i].chan_reg.cndtr = num_items;
> > > > +             buf_addr += period_len;
> > > > +     }
> > > > +
> > > > +     desc->num_sgs = num_periods;
> > > > +     desc->cyclic = true;
> > > > +
> > > > +     return vchan_tx_prep(&lchan->vchan, &desc->vdesc, flags);
> > > > +}
> > > > +
> > > > +static size_t loongson2_cmc_dma_desc_residue(struct loongson2_cmc_dma_chan *lchan,
> > > > +                                          struct loongson2_cmc_dma_desc *desc, u32 next_sg)
> > > > +{
> > > > +     struct loongson2_cmc_dma_dev *lddev = lmdma_get_dev(lchan);
> > > > +     u32 residue, width, ndtr, ccr, i;
> > > > +
> > > > +     ccr = loongson2_cmc_dma_read(lddev, LOONGSON2_CMCDMA_CCR, lchan->id);
> > > > +     width = FIELD_GET(LOONGSON2_CMCDMA_CCR_PSIZE_MASK, ccr);
> > > > +
> > > > +     ndtr = loongson2_cmc_dma_read(lddev, LOONGSON2_CMCDMA_CNDTR, lchan->id);
> > > > +     residue = ndtr << width;
> > > > +
> > > > +     if (lchan->desc->cyclic && next_sg == 0)
> > > > +             return residue;
> > > > +
> > > > +     for (i = next_sg; i < desc->num_sgs; i++)
> > > > +             residue += desc->sg_req[i].len;
> > > > +
> > > > +     return residue;
> > > > +}
> > > > +
> > > > +static enum dma_status loongson2_cmc_dma_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
> > > > +                                                struct dma_tx_state *state)
> > > > +{
> > > > +     struct loongson2_cmc_dma_chan *lchan = to_lmdma_chan(chan);
> > > > +     struct virt_dma_desc *vdesc;
> > > > +     enum dma_status status;
> > > > +     unsigned long flags;
> > > > +
> > > > +     status = dma_cookie_status(chan, cookie, state);
> > > > +     if (status == DMA_COMPLETE || !state)
> > > > +             return status;
> > > > +
> > > > +     spin_lock_irqsave(&lchan->vchan.lock, flags);
> > > > +     vdesc = vchan_find_desc(&lchan->vchan, cookie);
> > > > +     if (lchan->desc && cookie == lchan->desc->vdesc.tx.cookie)
> > > > +             state->residue = loongson2_cmc_dma_desc_residue(lchan, lchan->desc, lchan->next_sg);
> > > > +     else if (vdesc)
> > > > +             state->residue = loongson2_cmc_dma_desc_residue(lchan, to_lmdma_desc(vdesc), 0);
> > > > +
> > > > +     spin_unlock_irqrestore(&lchan->vchan.lock, flags);
> > > > +
> > > > +     return status;
> > > > +}
> > > > +
> > > > +static void loongson2_cmc_dma_free_chan_resources(struct dma_chan *chan)
> > > > +{
> > > > +     vchan_free_chan_resources(to_virt_chan(chan));
> > > > +}
> > > > +
> > > > +static void loongson2_cmc_dma_desc_free(struct virt_dma_desc *vdesc)
> > > > +{
> > > > +     kfree(to_lmdma_desc(vdesc));
> > > > +}
> > > > +
> > > > +static bool loongson2_cmc_dma_acpi_filter(struct dma_chan *chan, void *param)
> > > > +{
> > > > +     struct loongson2_cmc_dma_chan *lchan = to_lmdma_chan(chan);
> > > > +     struct acpi_dma_spec *dma_spec = param;
> > > > +
> > > > +     memset(&lchan->chan_reg, 0, sizeof(struct loongson2_cmc_dma_chan_reg));
> > > > +     lchan->chan_reg.ccr = dma_spec->chan_id & LOONGSON2_CMCDMA_STREAM_MASK;
> > > > +
> > > > +     return true;
> > > > +}
> > > > +
> > > > +static int loongson2_cmc_dma_acpi_controller_register(struct loongson2_cmc_dma_dev *lddev)
> > > > +{
> > > > +     struct device *dev = lddev->ddev.dev;
> > > > +     struct acpi_dma_filter_info *info;
> > > > +     int ret;
> > > > +
> > > > +     if (!has_acpi_companion(dev))
> > > > +             return 0;
> > > > +
> > > > +     info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
> > > > +     if (!info)
> > > > +             return -ENOMEM;
> > > > +
> > > > +     dma_cap_zero(info->dma_cap);
> > > > +     info->dma_cap = lddev->ddev.cap_mask;
> > > > +     info->filter_fn = loongson2_cmc_dma_acpi_filter;
> > > > +
> > > > +     ret = devm_acpi_dma_controller_register(dev, acpi_dma_simple_xlate, info);
> > > > +     if (ret)
> > > > +             dev_err(dev, "could not register acpi_dma_controller\n");
> > > > +
> > > > +     return ret;
> > > > +}
> > > > +
> > > > +static struct dma_chan *loongson2_cmc_dma_of_xlate(struct of_phandle_args *dma_spec,
> > > > +                                                struct of_dma *ofdma)
> > > > +{
> > > > +     struct loongson2_cmc_dma_dev *lddev = ofdma->of_dma_data;
> > > > +     struct device *dev = lddev->ddev.dev;
> > > > +     struct loongson2_cmc_dma_chan *lchan;
> > > > +     struct dma_chan *chan;
> > > > +
> > > > +     if (dma_spec->args_count < 2)
> > > > +             return NULL;
> > > > +
> > > > +     if (dma_spec->args[0] >= lddev->nr_channels) {
> > > > +             dev_err(dev, "Invalid channel id\n");
> > > > +             return NULL;
> > > > +     }
> > > > +
> > > > +     lchan = &lddev->chan[dma_spec->args[0]];
> > > > +     chan = dma_get_slave_channel(&lchan->vchan.chan);
> > > > +     if (!chan) {
> > > > +             dev_err(dev, "No more channels available\n");
> > > > +             return NULL;
> > > > +     }
> > > > +
> > > > +     memset(&lchan->chan_reg, 0, sizeof(struct loongson2_cmc_dma_chan_reg));
> > > > +     lchan->chan_reg.ccr = dma_spec->args[1] & LOONGSON2_CMCDMA_STREAM_MASK;
> > > > +
> > > > +     return chan;
> > > > +}
> > > > +
> > > > +static int loongson2_cmc_dma_of_controller_register(struct loongson2_cmc_dma_dev *lddev)
> > > > +{
> > > > +     struct device *dev = lddev->ddev.dev;
> > > > +     int ret;
> > > > +
> > > > +     if (!dev->of_node)
> > > > +             return 0;
> > > > +
> > > > +     ret = of_dma_controller_register(dev->of_node, loongson2_cmc_dma_of_xlate, lddev);
> > > > +     if (ret)
> > > > +             dev_err(dev, "could not register of_dma_controller\n");
> > > > +
> > > > +     return ret;
> > > > +}
> > > > +
> > > > +static int loongson2_cmc_dma_probe(struct platform_device *pdev)
> > > > +{
> > > > +     const struct loongson2_cmc_dma_config *config;
> > > > +     struct loongson2_cmc_dma_chan *lchan;
> > > > +     struct loongson2_cmc_dma_dev *lddev;
> > > > +     struct device *dev = &pdev->dev;
> > > > +     struct dma_device *ddev;
> > > > +     u32 nr_chans, i;
> > > > +     int ret;
> > > > +
> > > > +     config = (const struct loongson2_cmc_dma_config *)device_get_match_data(dev);
> > > > +     if (!config)
> > > > +             return -EINVAL;
> > > > +
> > > > +     ret = device_property_read_u32(dev, "dma-channels", &nr_chans);
> > > > +     if (ret || nr_chans > config->max_channels) {
> > > > +             dev_err(dev, "missing or invalid dma-channels property\n");
> > > > +             nr_chans = config->max_channels;
> > > > +     }
> > > > +
> > > > +     lddev = devm_kzalloc(dev, struct_size(lddev, chan, nr_chans), GFP_KERNEL);
> > > > +     if (!lddev)
> > > > +             return -ENOMEM;
> > > > +
> > > > +     lddev->base = devm_platform_ioremap_resource(pdev, 0);
> > > > +     if (IS_ERR(lddev->base))
> > > > +             return PTR_ERR(lddev->base);
> > > > +
> > > > +     platform_set_drvdata(pdev, lddev);
> > > > +     lddev->nr_channels = nr_chans;
> > > > +     lddev->chan_reg_offset = config->chan_reg_offset;
> > > > +
> > > > +     lddev->dma_clk = devm_clk_get_optional_enabled(dev, NULL);
> > > > +     if (IS_ERR(lddev->dma_clk))
> > > > +             return dev_err_probe(dev, PTR_ERR(lddev->dma_clk), "Failed to get dma clock\n");
> > > > +
> > > > +     ddev = &lddev->ddev;
> > > > +     ddev->dev = dev;
> > > > +
> > > > +     dma_cap_zero(ddev->cap_mask);
> > > > +     dma_cap_set(DMA_SLAVE, ddev->cap_mask);
> > > > +     dma_cap_set(DMA_PRIVATE, ddev->cap_mask);
> > > > +     dma_cap_set(DMA_CYCLIC, ddev->cap_mask);
> > > > +
> > > > +     ddev->device_free_chan_resources = loongson2_cmc_dma_free_chan_resources;
> > > > +     ddev->device_config = loongson2_cmc_dma_slave_config;
> > > > +     ddev->device_prep_slave_sg = loongson2_cmc_dma_prep_slave_sg;
> > > > +     ddev->device_prep_dma_cyclic = loongson2_cmc_dma_prep_dma_cyclic;
> > > > +     ddev->device_issue_pending = loongson2_cmc_dma_issue_pending;
> > > > +     ddev->device_synchronize = loongson2_cmc_dma_synchronize;
> > > > +     ddev->device_tx_status = loongson2_cmc_dma_tx_status;
> > > > +     ddev->device_terminate_all = loongson2_cmc_dma_terminate_all;
> > > > +
> > > > +     ddev->src_addr_widths = LOONGSON2_CMCDMA_BUSWIDTHS;
> > > > +     ddev->dst_addr_widths = LOONGSON2_CMCDMA_BUSWIDTHS;
> > > > +     ddev->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
> > > > +     INIT_LIST_HEAD(&ddev->channels);
> > >
> > > where use this 'channels' ?
> >
> > It will be used by global functions such as `dma_async_device_register()`.

Okay, supposed it sould be done in dma_async_device_register().

Frank
> > >
> > > Frank
> > > > +
> > > > +     for (i = 0; i < nr_chans; i++) {
> > > > +             lchan = &lddev->chan[i];
> > > > +
> > > > +             lchan->id = i;
> > > > +             lchan->vchan.desc_free = loongson2_cmc_dma_desc_free;
> > > > +             vchan_init(&lchan->vchan, ddev);
> > > > +     }
> > > > +
> > > > +     ret = dmaenginem_async_device_register(ddev);
> > > > +     if (ret)
> > > > +             return ret;
> > > > +
> > > > +     for (i = 0; i < nr_chans; i++) {
> > > > +             lchan = &lddev->chan[i];
> > > > +
> > > > +             lchan->irq = platform_get_irq(pdev, i);
> > > > +             if (lchan->irq < 0)
> > > > +                     return lchan->irq;
> > > > +
> > > > +             ret = devm_request_irq(dev, lchan->irq, loongson2_cmc_dma_chan_irq, IRQF_SHARED,
> > > > +                                    dev_name(chan2dev(lchan)), lchan);
> > > > +             if (ret)
> > > > +                     return ret;
> > > > +     }
> > > > +
> > > > +     ret = loongson2_cmc_dma_acpi_controller_register(lddev);
> > > > +     if (ret)
> > > > +             return ret;
> > > > +
> > > > +     return loongson2_cmc_dma_of_controller_register(lddev);
> > > > +}
> > > > +
> > > > +static void loongson2_cmc_dma_remove(struct platform_device *pdev)
> > > > +{
> > > > +     of_dma_controller_free(pdev->dev.of_node);
> > > > +}
> > > > +
> > > > +static const struct of_device_id loongson2_cmc_dma_of_match[] = {
> > > > +     { .compatible = "loongson,ls2k0300-dma", .data = &ls2k0300_cmc_dma_config },
> > > > +     { .compatible = "loongson,ls2k3000-dma", .data = &ls2k3000_cmc_dma_config },
> > > > +     { /* sentinel */ }
> > > > +};
> > > > +MODULE_DEVICE_TABLE(of, loongson2_cmc_dma_of_match);
> > > > +
> > > > +static const struct acpi_device_id loongson2_cmc_dma_acpi_match[] = {
> > > > +     { "LOON0014", .driver_data = (kernel_ulong_t)&ls2k3000_cmc_dma_config },
> > > > +     { /* sentinel */ }
> > > > +};
> > > > +MODULE_DEVICE_TABLE(acpi, loongson2_cmc_dma_acpi_match);
> > > > +
> > > > +static struct platform_driver loongson2_cmc_dma_driver = {
> > > > +     .driver = {
> > > > +             .name = "loongson2-apb-cmc-dma",
> > > > +             .of_match_table = loongson2_cmc_dma_of_match,
> > > > +             .acpi_match_table = loongson2_cmc_dma_acpi_match,
> > > > +     },
> > > > +     .probe = loongson2_cmc_dma_probe,
> > > > +     .remove = loongson2_cmc_dma_remove,
> > > > +};
> > > > +module_platform_driver(loongson2_cmc_dma_driver);
> > > > +
> > > > +MODULE_DESCRIPTION("Looongson-2 Multi-Channel DMA Controller driver");
> > > > +MODULE_AUTHOR("Loongson Technology Corporation Limited");
> > > > +MODULE_LICENSE("GPL");
> > > > --
> > > > 2.52.0
> > > >
> >
> > --
> > Thanks.
> > Binbin
>
> --
> Thanks.
> Binbin

