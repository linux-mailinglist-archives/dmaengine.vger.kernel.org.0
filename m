Return-Path: <dmaengine+bounces-4034-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A879F784C
	for <lists+dmaengine@lfdr.de>; Thu, 19 Dec 2024 10:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27C121697AD
	for <lists+dmaengine@lfdr.de>; Thu, 19 Dec 2024 09:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0196223C62;
	Thu, 19 Dec 2024 09:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="s0mWOSwi"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2052.outbound.protection.outlook.com [40.107.22.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF423223719;
	Thu, 19 Dec 2024 09:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734600070; cv=fail; b=Oc/4EfDw9UtN9MR6N8XEEmc/TLNzGllmSgB+ErM4NsVlIEBqJPYa7TcbdWNVfFQxZX3ZYtNN3LAFL8gbpfwuwnDcc331tpbw5BQfjIx75w1uq11XF9iM9go75wyROts16UUN2SqiWDofKB+6GKOkd25ChhcOXiR4AEPoraFV9eo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734600070; c=relaxed/simple;
	bh=HmGCBiXoSrLxJwMM4N4YHRHB1wg19cbqt0DXJEaz1TQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EdnoWWHtatGGkWfMOijSdwzz7D21EMK/fkuC4WZisHpdLyv2FRCEzOjepuquM+Bs4jQ2tUsVJbrTKJNd7shNRIP4Gn6+9CSwxrfLYWOfxZ/n1PR5/5MfC6mm/EkikunvtxgpzuCg5qApJ4Sn4/mT9g80s1qi67PKFVHx9vpY+CI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=s0mWOSwi; arc=fail smtp.client-ip=40.107.22.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WsN3tEoaj+pAxZAcSiV/xm1vT9/7FxP3rOl4Kp/M+5P4pEiWNbt5XHicd2O4fZEZiDzQp4+Th+QL7dPeGLsml5yR3lynoszhcqdebePTu4Ply0VA3fP/KPzwaghr/KaMOAzNCfEGoxUf8/y0tybSpI0YE7O72QEF26MrwMJe4JB1xSCIHcUbwbBJFXdwGx0G+N4eO+hkY8C688QCnISf1gl6WlGpDWxY4jSqg4fr4bJ2OTYlo3mDv90lpBkm+eJClKK5kklOpx0avxQBgEFGTpkxdGWv3EjuO8BccWID/WHUq5APMllpUVYchkEh4EMFD58sV4Gs8QwWqu/Ty1i9JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mc/TtVZP9h6Q5W2GpYNktrmwxyrCTzOZfm5JA7UiZkg=;
 b=SKRfYFfq4S1nidjF4yvtfYBQBEmIhiGmGDFkG+cJuqA6/wvOXkn4lg/YgltLPrzyrra7bMdd7L48FF/43CJIw5vGGE/dK134Gb8bhHV7Vi06L3sR3sifGYqAZgVFINWfEypjuGrDBEuX4ETeBKbZO1Q15Kl7A9I+WtfUCHhUPr3LyO4uLJPG0Sz5Qy6MQBCvqpN9i40d4pn1u/jJqo+BY/WM5wfAOZLUWNCsp9hGJNr4CbQknDTqt3hnbLFoMACUl/xFpzxOF3IblSEi/mV/2Yr+X7p8hcZE+LhLj9/B1bh/Bucf6vSTutzX1K8W30l3z2FnEgJcMLz94W8A0gxG4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mc/TtVZP9h6Q5W2GpYNktrmwxyrCTzOZfm5JA7UiZkg=;
 b=s0mWOSwikFlMkLwCF+/bXt3OXRm95O5ViObneGw58OwXSJPf8eyovmbmlBeGDGki8hPF71Yo0BifAa0uVSka1YuT2jEeJrpHgAs8egdmKwsPy/3b5v3BF9s2cvOEUw/L2l3CcohblzrgU/YikgKILx2KxMxiFef6aZPcu+J6R4peF4ZpVuNWfbQKPta4Tn9PHL+VP6BUYoMHO2N6aw9WijkS+wi2lFU26dCd4CBHX/6cN903UeHDOEOiZddKLjNZuHN2jCx9og+C1TUKkoMvPHZb9GtkoJS579V8+t0Al03lzQ32yLCp/fvjonYLsZn8Z9NQ2ycIG8RuC6MBgAPP3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9550.eurprd04.prod.outlook.com (2603:10a6:20b:4f9::17)
 by VI1PR04MB9834.eurprd04.prod.outlook.com (2603:10a6:800:1d8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Thu, 19 Dec
 2024 09:21:00 +0000
Received: from AS4PR04MB9550.eurprd04.prod.outlook.com
 ([fe80::e28d:10f8:289:baf7]) by AS4PR04MB9550.eurprd04.prod.outlook.com
 ([fe80::e28d:10f8:289:baf7%6]) with mapi id 15.20.8251.015; Thu, 19 Dec 2024
 09:21:00 +0000
From: Larisa Grigore <larisa.grigore@oss.nxp.com>
To: Frank Li <Frank.Li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peng Fan <peng.fan@nxp.com>
Cc: imx@lists.linux.dev,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	s32@nxp.com,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Larisa Grigore <larisa.grigore@oss.nxp.com>,
	Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
Subject: [PATCH v2 4/6] dmaengine: fsl-edma: add support for S32G based platforms
Date: Thu, 19 Dec 2024 11:18:44 +0200
Message-ID: <20241219092045.1161182-5-larisa.grigore@oss.nxp.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241219092045.1161182-1-larisa.grigore@oss.nxp.com>
References: <20241219092045.1161182-1-larisa.grigore@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0200.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::7) To AS4PR04MB9550.eurprd04.prod.outlook.com
 (2603:10a6:20b:4f9::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9550:EE_|VI1PR04MB9834:EE_
X-MS-Office365-Filtering-Correlation-Id: 96e79252-d310-4aaf-9f19-08dd200e73fe
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?clNoQU5hbFM3S1JaeDVsd2cwYmVwRWIyOHFFd2VZZVE0S2VmSjJ0cXZhemJK?=
 =?utf-8?B?V3IxU05ITldQdFlRT3FoRURJUW1wTGJ2b09DdVRkOFZXUGJpNTR0bmRZREJl?=
 =?utf-8?B?N0YxTi9HblVVS0NrdEVGaTBnSm1RMTJmcHh2Q25JVEZmZ0l3VU9zdmxoaEo5?=
 =?utf-8?B?TVc5SlNhWnNickQ4V3ZPTVZvdWNHN1R4K1RlamdjNjMxWDZ5SXRzdk02UTIw?=
 =?utf-8?B?L2VhVENPak94d1hNZGY1K2RQcTEzbUZxNzc4TEwxdmVlSWtYcDJ2NHRpdVU1?=
 =?utf-8?B?eDY1Snd3VDdsNE1qbWY3SzRFRGV3Ym16aiswSmt6WHR5T3poUGlHVW1kcngx?=
 =?utf-8?B?MlpqYndEcWJOWElBUkVKRTV6WUxJamh6OUpPN1d1cDhFK2V0WEV1MU1ocWZX?=
 =?utf-8?B?QnRncmRWd2U4K2M4N2hHSzB0YUhJTGRtMk9CQlRzd29tdyszNVVXWUZSeVc4?=
 =?utf-8?B?N1JCY0tobjhQU3dNMzhaemJLUGRyL1dFS1J1ZnJwRlE2ZnNQR0ZaN2FDdUdT?=
 =?utf-8?B?RVN5bVJtWlRBcTN5QVMxYW41YzZjZjFVYTY4bUxvaDBTRFQ5Y21LMXVBL3Y1?=
 =?utf-8?B?bTF5WVhRRjF1Q2xQT20yUTNtZHMrQU40OXdCcmEwZjU3SlM1MzVwT3YxR0dw?=
 =?utf-8?B?aitkZm05VmIwbDU2S3E5VjZyWHRWbU9xVUVpSTNLZTNmaWRnc1BVbUdIdlhp?=
 =?utf-8?B?NmJ6YS9tRDJwSnFCTSttRmlLWk5BaDBGdE84TEs2aXlmNk00MnNWTDdrY3pF?=
 =?utf-8?B?SGVZcEhPSXBxSTlOTitUY0QzV1RhcDlSZDcrWVZZWjN5Z3JnN29ZYm1kOFFj?=
 =?utf-8?B?V25NeUdtMm5zY1ZtaE5vbWVBMlV6N0tiNUZoK2tJT3dSTlRmaUcwM2ZRZWRF?=
 =?utf-8?B?cktBTEw0bDNKbnhHa2QxU1VrWExQSytPcUx5MktYNDFUTy94azJiaGJucjJu?=
 =?utf-8?B?T2FzOXJTY0tIRFRJMU5qbDNCekhIL1VUOHFHYzhGNHZYZnlzN0VqU2NIQkJy?=
 =?utf-8?B?VzZLUWZWSzkxSndLSmxGQ1hTaElXQUsxa2xTYVJxVkZNNnJ6bEtFL0ZVTWJF?=
 =?utf-8?B?UmhIbGNKOU1Ya244WDQyd1B1UTNGRFhXOHYyRVJGRWdpcitMMDNBbVF4UVJC?=
 =?utf-8?B?NzA0bGpLVGVkMlhhVm1LRnVtN09QRnpKUzZLV1gyNWlacHNidDJoWGdiSnFk?=
 =?utf-8?B?SjkrdXljRXk0RjJIeHd5Q2ZpYk42NEhZVmdSNktTdkJCenQrQ0tmTm1tNU0y?=
 =?utf-8?B?djJaRkp0WWI4bTlzUE1jSkYzN0NMY05WSmpiTFhtMTFrZk40TFNXeXpPRXda?=
 =?utf-8?B?OXNuWDBoSGpZWWs4cVd6QWxvdFdmYndjSzhLRTZWbDBQaDNWU200bVRyd0Vl?=
 =?utf-8?B?d0kzajNNaFo1MUVYUm1wLzMvK21ZM3k4RysyV3JFaEdBTEZVVmNJeFVVa0xi?=
 =?utf-8?B?dXhWeGtINGc0Q2hwbzZLajFZQU43MHhFb1lOR05IcVlMUEwyWXRqblZkTHlC?=
 =?utf-8?B?aEVuS3FOWHREM1ZhWEdzUWphRkxnMVVuSHNsSzFweXVEZkZ5MGhhT3A5cnc3?=
 =?utf-8?B?RDNncWM1VmxHb1RXeE5QdTJtaFZnSlJta0JQOEU5M2g4M09kc1JPbTRtSG84?=
 =?utf-8?B?ZU10TW5KUHZCWThLMEExTDBORlB1cTdqeWhuNG41TVErOXZOc3JWOXNhalBT?=
 =?utf-8?B?eEZTNDhVSEo0bjdtOTY4TUlSRmI3OWEzZGVtdGc5ODFmQnZ0MUV3S0E0Rlpv?=
 =?utf-8?B?RmxGOGNXYWhuZG44UEgwaVBJaS9FcGw4b2hSdm1OSGRPTGgwRU1Nc05QSHpq?=
 =?utf-8?B?WTNFQk9GYnhyWCtURGFSUE1hcmJaVWNLSEphYklJZHpSb2JRcnBSenhQK1BW?=
 =?utf-8?Q?nqWzwShIk9t9f?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9550.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnJWUy93d0c3bzBmZzZhL1VJRHRqb2pxZkdsSzdyM0JCUTRCaWovL0pudTRv?=
 =?utf-8?B?bUhDeCtsU2oyYjlXY0JIVUI0YUhkVzBxWWdFWlpybFc3WkZhdEdDNHFXa3Rw?=
 =?utf-8?B?MVBBa3FobHVnYXRnNUhwQnNHbUJHTTkwenU0ZXU4T210ZFM5QW9aenpwU1Nz?=
 =?utf-8?B?MERVK3RIR3JSZUo2UU5PQ01LNCtyVTFPNDR6QUFQdkc1OVBlaTZGL1IzUFZ0?=
 =?utf-8?B?Zm8zLzNacDdVM21hR2d4cE9EaC9TQWZncVRpUDVUaTFtVXozKytjSnRJQ1BL?=
 =?utf-8?B?YXRyTDAvM2NtVFJycEMycGFvOThzdWVreTk0UVNHeFZQdXVsVHlER1dYMDhH?=
 =?utf-8?B?eXRRN0g5cWJxMmIwUU9janhLc2xCMHNFVzJJYkpxbnBEZ29XQlRKbU1KNUVv?=
 =?utf-8?B?MCtRaURPR0FBQk16bzdnNW9Ma1BqWlZmTy9ralJVS1dFNjNZZC84K3dyUURi?=
 =?utf-8?B?cnltVHlPcVk1ZStQVEVOTXdlTCtUMjU3OGR3bFZJemZPNVRkZ3ppOGUyL3lm?=
 =?utf-8?B?dEQ3YjRDdDNDcUI3SHFGeGpCQmlocEVMb1V0dUR2YVlIRVJqeUVkTnZLYWw1?=
 =?utf-8?B?TjVtWmNtM01oUUdxR1MvMS91aUxGUFBlMFNxSmd1TVNSMFJyRllLMWtVeDhh?=
 =?utf-8?B?Q3dDcER4UDdPNUh0S0RpMkNZaU5zZ1NRYWcxMjhxUTdETllYQkxsVmoreCsv?=
 =?utf-8?B?ejdDQ1dnZnp5enRyT3RzbFVGcGY0ZjJUTTl5S2Jkby9rdDFsNmtWT2lsTEhB?=
 =?utf-8?B?dDhzL05nUi9lV3lSb1g3VTdlbVUvTnVtblgwTjJTMmdEaHVybDFXck9VeVF4?=
 =?utf-8?B?bDNyNmk0UEVnT2RubkVrYmpoMSsxVTVIbFYwdWN0ZElzM3c5YzJWSVpCSG1E?=
 =?utf-8?B?cnI5Yzc0T3Y4OFB2RnlRSC8rUHhsR3AwRnFGRC9oQW4zNTNQT1YyWFFOR2ds?=
 =?utf-8?B?Vk9DRzlZV09pSGNpVjFoa003RVFWNWlDNit1VnErNnF3alpmVElwb0VrU3Nu?=
 =?utf-8?B?aUlCbyt2OTYvaUlXTlpoSnB5dXJka1RBVE1PdExINWNGazZkWGVmQTI5Z29i?=
 =?utf-8?B?LzVFYmdoandPUTVwRmhBbFVPcms1eDVzWXZhVVVTRmZWYk05YnhNY1hieW1a?=
 =?utf-8?B?TDF0NmFpRTF5dkxXYVVPVXBHVmk5MGQxdUhqcStNUHRSUHkxV1JjS3dJU0tM?=
 =?utf-8?B?Rm9mWVhLeDg3emplYWRJTmRRblg4NHdiKzNjM2l1elRPaURBcUFya2syd21T?=
 =?utf-8?B?SGR0aGVCSVJ3Q2lxRG9FUkh2c1J4cEVhaENRVTE4cXI1UGluWThOUEszZEZv?=
 =?utf-8?B?SSt5Mk0yZkhrcFJJYVBTRWVQQWpBQmRTaVBaVDNzMmk5WmFSTkk5TGdyWmIw?=
 =?utf-8?B?WHAzakVnVnpiNldoNHk3QlNISmJCUi9McmJmUnlTSW1kQ3NTL3FTWDI5eEw4?=
 =?utf-8?B?SWU2R3A1emREdlVqTGE2R0ZEMW1kSWwvODR5VUVMT3BOQWhRYUdmZjl1aFhI?=
 =?utf-8?B?QzVGSmZBZHFjSWlWNUhORG1JMzdvNm9uS2hxMlN3WTZHTjFyaWVPM0ptcThB?=
 =?utf-8?B?K2RZRElRR3V4NzRYYVRycER0THFCY3lsMk9lZkZ0K20rQ2ZENUdIMFN6aG1I?=
 =?utf-8?B?S2ltWDdyS2pYKzNlNUdnYk5GNEZ5M2FTUDR6QTFmeGUvNFB5aTh3d1c0WnhR?=
 =?utf-8?B?c1ozWnlrRTk0YTdrRTNDdzJXZ0Erb2xtejQ2TER3bjVBVjdGWHM2R3grcWRv?=
 =?utf-8?B?bXlXNzFKdVJ2dDM0a2tPOFdrQ3YwS0dOQjlDNlRFVFBxMkFFNENROWdUL3V5?=
 =?utf-8?B?K3h6VmxqZ21QdnZFN0UwT0hKSzhWSkFIY0VuVXhwRVlFZlJVbHBYazNvMzlm?=
 =?utf-8?B?STUxWm9lZVp1K3Z5dFdIS3IzcjkrcGE4bE5wWlFYUkhmTGFiYURvdzNORUtK?=
 =?utf-8?B?TVpvTmRLcnFvQXk4TlVBQVBCYXZTb2VadHN0LzlaNWwyTC9tKzd3ZnUxSWQv?=
 =?utf-8?B?TTJKamppTFpZa2ZMaklyMmwzM2xtcHMzK2Ric0lBSFpnN0NMMGVPMDNCWHM4?=
 =?utf-8?B?eE1hVVVDcGUwUEYwZkN6VE5oaElLYklUaW1zcktWN0w2bXJDTmsvMXJpeEhT?=
 =?utf-8?Q?Vw+grk5Dwarl6URGb9IxrGsIr?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96e79252-d310-4aaf-9f19-08dd200e73fe
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9550.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 09:21:00.5320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /uoFSXx5Tq/qnyrmwlfjKMV17i4JXntRA4cjor6qFY97SlSk2b1b5MGkDuBzwJEV3QF58QDCMXCjALGfhwbEsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9834

S32G2/S32G3 includes two system eDMA instances based on v3 version, each of
them integrated with two DMAMUX blocks.

Another particularity of these SoCs is that the interrupts are shared
between channels as follows:
- DMA Channels 0-15 share the 'tx-0-15' interrupt
- DMA Channels 16-31 share the 'tx-16-31' interrupt
- all channels share the 'err' interrupt

Signed-off-by: Larisa Grigore <larisa.grigore@oss.nxp.com>
Co-developed-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-common.h |   3 +
 drivers/dma/fsl-edma-main.c   | 109 +++++++++++++++++++++++++++++++++-
 2 files changed, 111 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index ce37e1ee9c46..707fea4139b6 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -68,6 +68,8 @@
 #define EDMA_V3_CH_CSR_EEI         BIT(2)
 #define EDMA_V3_CH_CSR_DONE        BIT(30)
 #define EDMA_V3_CH_CSR_ACTIVE      BIT(31)
+#define EDMA_V3_CH_ES_ERR          BIT(31)
+#define EDMA_V3_MP_ES_VLD          BIT(31)
 
 enum fsl_edma_pm_state {
 	RUNNING = 0,
@@ -240,6 +242,7 @@ struct fsl_edma_engine {
 	const struct fsl_edma_drvdata *drvdata;
 	u32			n_chans;
 	int			txirq;
+	int			txirq_16_31;
 	int			errirq;
 	bool			big_endian;
 	struct edma_regs	regs;
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 9873cce00c68..c9e3252d0da0 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -3,10 +3,11 @@
  * drivers/dma/fsl-edma.c
  *
  * Copyright 2013-2014 Freescale Semiconductor, Inc.
+ * Copyright 2024 NXP
  *
  * Driver for the Freescale eDMA engine with flexible channel multiplexing
  * capability for DMA request sources. The eDMA block can be found on some
- * Vybrid and Layerscape SoCs.
+ * Vybrid, Layerscape and S32G SoCs.
  */
 
 #include <dt-bindings/dma/fsl-edma.h>
@@ -72,6 +73,60 @@ static irqreturn_t fsl_edma2_tx_handler(int irq, void *devi_id)
 	return fsl_edma_tx_handler(irq, fsl_chan->edma);
 }
 
+static irqreturn_t fsl_edma3_or_tx_handler(int irq, void *dev_id,
+					   u8 start, u8 end)
+{
+	struct fsl_edma_engine *fsl_edma = dev_id;
+	struct fsl_edma_chan *chan;
+	int i;
+
+	end = min(end, fsl_edma->n_chans);
+
+	for (i = start; i < end; i++) {
+		chan = &fsl_edma->chans[i];
+
+		fsl_edma3_tx_handler(irq, chan);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t fsl_edma3_tx_0_15_handler(int irq, void *dev_id)
+{
+	return fsl_edma3_or_tx_handler(irq, dev_id, 0, 16);
+}
+
+static irqreturn_t fsl_edma3_tx_16_31_handler(int irq, void *dev_id)
+{
+	return fsl_edma3_or_tx_handler(irq, dev_id, 16, 32);
+}
+
+static irqreturn_t fsl_edma3_or_err_handler(int irq, void *dev_id)
+{
+	struct fsl_edma_engine *fsl_edma = dev_id;
+	struct edma_regs *regs = &fsl_edma->regs;
+	unsigned int err, ch, ch_es;
+	struct fsl_edma_chan *chan;
+
+	err = edma_readl(fsl_edma, regs->es);
+	if (!(err & EDMA_V3_MP_ES_VLD))
+		return IRQ_NONE;
+
+	for (ch = 0; ch < fsl_edma->n_chans; ch++) {
+		chan = &fsl_edma->chans[ch];
+
+		ch_es = edma_readl_chreg(chan, ch_es);
+		if (!(ch_es & EDMA_V3_CH_ES_ERR))
+			continue;
+
+		edma_writel_chreg(chan, EDMA_V3_CH_ES_ERR, ch_es);
+		fsl_edma_disable_request(chan);
+		fsl_edma->chans[ch].status = DMA_ERROR;
+	}
+
+	return IRQ_HANDLED;
+}
+
 static irqreturn_t fsl_edma_err_handler(int irq, void *dev_id)
 {
 	struct fsl_edma_engine *fsl_edma = dev_id;
@@ -274,6 +329,49 @@ static int fsl_edma3_irq_init(struct platform_device *pdev, struct fsl_edma_engi
 	return 0;
 }
 
+static int fsl_edma3_or_irq_init(struct platform_device *pdev,
+				 struct fsl_edma_engine *fsl_edma)
+{
+	int ret;
+
+	fsl_edma->txirq = platform_get_irq_byname(pdev, "tx-0-15");
+	if (fsl_edma->txirq < 0)
+		return fsl_edma->txirq;
+
+	fsl_edma->txirq_16_31 = platform_get_irq_byname(pdev, "tx-16-31");
+	if (fsl_edma->txirq_16_31 < 0)
+		return fsl_edma->txirq_16_31;
+
+	fsl_edma->errirq = platform_get_irq_byname(pdev, "err");
+	if (fsl_edma->errirq < 0)
+		return fsl_edma->errirq;
+
+	ret = devm_request_irq(&pdev->dev, fsl_edma->txirq,
+			       fsl_edma3_tx_0_15_handler, 0, "eDMA tx0_15",
+			       fsl_edma);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+			       "Can't register eDMA tx0_15 IRQ.\n");
+
+	if (fsl_edma->n_chans > 16) {
+		ret = devm_request_irq(&pdev->dev, fsl_edma->txirq_16_31,
+				       fsl_edma3_tx_16_31_handler, 0,
+				       "eDMA tx16_31", fsl_edma);
+		if (ret)
+			return dev_err_probe(&pdev->dev, ret,
+					"Can't register eDMA tx16_31 IRQ.\n");
+	}
+
+	ret = devm_request_irq(&pdev->dev, fsl_edma->errirq,
+			       fsl_edma3_or_err_handler, 0, "eDMA err",
+			       fsl_edma);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Can't register eDMA err IRQ.\n");
+
+	return 0;
+}
+
 static int
 fsl_edma2_irq_init(struct platform_device *pdev,
 		   struct fsl_edma_engine *fsl_edma)
@@ -404,6 +502,14 @@ static struct fsl_edma_drvdata imx95_data5 = {
 	.setup_irq = fsl_edma3_irq_init,
 };
 
+static const struct fsl_edma_drvdata s32g2_data = {
+	.dmamuxs = DMAMUX_NR,
+	.chreg_space_sz = EDMA_TCD,
+	.chreg_off = 0x4000,
+	.flags = FSL_EDMA_DRV_EDMA3 | FSL_EDMA_DRV_MUX_SWAP,
+	.setup_irq = fsl_edma3_or_irq_init,
+};
+
 static const struct of_device_id fsl_edma_dt_ids[] = {
 	{ .compatible = "fsl,vf610-edma", .data = &vf610_data},
 	{ .compatible = "fsl,ls1028a-edma", .data = &ls1028a_data},
@@ -413,6 +519,7 @@ static const struct of_device_id fsl_edma_dt_ids[] = {
 	{ .compatible = "fsl,imx93-edma3", .data = &imx93_data3},
 	{ .compatible = "fsl,imx93-edma4", .data = &imx93_data4},
 	{ .compatible = "fsl,imx95-edma5", .data = &imx95_data5},
+	{ .compatible = "nxp,s32g2-edma", .data = &s32g2_data},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, fsl_edma_dt_ids);
-- 
2.47.0


