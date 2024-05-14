Return-Path: <dmaengine+bounces-2032-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 578378C5993
	for <lists+dmaengine@lfdr.de>; Tue, 14 May 2024 18:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09D9D283D69
	for <lists+dmaengine@lfdr.de>; Tue, 14 May 2024 16:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B2D181CF6;
	Tue, 14 May 2024 16:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gbzYFRFJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2048.outbound.protection.outlook.com [40.107.6.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2358181333;
	Tue, 14 May 2024 16:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715703383; cv=fail; b=MuGJ3d4CLG9gMYRnzNjxHiV6z3dc5QbI7xxiM9zvgtHFcunCGU91lpYZ1MTe+kCmNZBQQSq+elkqQurCe6FZEvlj+3Fx4ODs0rSlNH3G4RS+zus/4cJpDZ7UlTXoQw4siPRr4OWid0SGdIDF0vP/DbdVcqpbwtwhZ3BhbzxgzxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715703383; c=relaxed/simple;
	bh=o14XS22P/netJvJtqUCgQ7C4J9kLM7Xh7A/m0JadBo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QaCEHKUniy15c2FzGO9Tw2fZHc9OtYWnU+2m+asMeVZihrgg3IomDJjVEUMK8MAHzvNoI+bZ5nsaqmf9rlktiedyeI8IGq0vubHeMzyt7pcGNzh9p9Izq2i3YqmHyasNBo5sVWFSjRbCyRFofn5fjIwszrwMFSMVdvX/tiFyhO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=gbzYFRFJ; arc=fail smtp.client-ip=40.107.6.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HA/aEQsF0J7bvzMX6/fpEHMuxJs+eaPLSCsY3/pt7tBUL6f3/56dII7f/9xS/qVislao0rhAQw8iq0GeLbzX/gBWPLVzRuxb+VfJtJpr5Ot6cUhq+qfvQm/Pa2NDt0rHyzVQRB54a3QxmcyE++MRCmdW4pan9u0Usd3BfQSCZqOZf+uOwOrHKmczzU+XFBdhLcWBqGCOzy2EdzAqvOnoLYE7xpqwL3WwOA7gxy+LhbUt8GIfuu727rzVoDfbpQf6CNpYovv02XMlOemf0L30ddzQC3SjwmR0X6FbiC+zncJ7t0M6fXj/VjrK/ZEDzSWBxVWwebiYZJ6xLqM092TEmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQzx3MFUg11Hsctkni0/a+wPSAxgL1O62pZbnHv3sIo=;
 b=WqcpKxcZweNUTPHAMmLJtpjz/B2exj3OZmnZnGQIhztSCAjOpdpZDQHcqROvDBpHM2xhScQxBZDHhaoPO/opcRSo5yKUlJ/sQAJ7uGGnCFC5LVPNX08sObkBA9wQP/IILdyWELfo15MCLBwoqqUJ9xsyu6wiyxhhaEnbmGSsaVtT/JLIT+O55lw7r9i2ecBGzMkcy6lV2sIyhP/VlSsCyN0d6hjCqkNcxe2rXI4ZMFzM1sRsDUZKNWMd+2zJaLM74gbT3zBCBDKQg4EsEcspiN35ML+jtcuElHLrj9NCjWyZCSeK0OXen8aDwjAS55h3UgLh7kff68ilpb8iSrWNcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQzx3MFUg11Hsctkni0/a+wPSAxgL1O62pZbnHv3sIo=;
 b=gbzYFRFJwjDHW4ajy6f3Ahj61HgOXKPPe3XQwzcnKq23KF+1/EwhL/Tg7Qj5HZZP6yEHz1z9/kxebV7cuXicGWxyZsb1KldRYHvJpgny/YEJpe6nF87YISgxra2W8MA13xdvkOxvr8E91lPXFWZNn5GyWtFqBszdiSYQh/T05Zw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DU4PR04MB10887.eurprd04.prod.outlook.com (2603:10a6:10:592::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.21; Tue, 14 May
 2024 16:16:17 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%5]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 16:16:17 +0000
Date: Tue, 14 May 2024 12:16:09 -0400
From: Frank Li <Frank.li@nxp.com>
To: Angelo Dureghello <angelo@kernel-space.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Vinod Koul <vkoul@kernel.org>,
	"open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" <dmaengine@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:FREESCALE eDMA DRIVER" <imx@lists.linux.dev>,
	Greg Ungerer <gerg@linux-m68k.org>,
	linux-m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: [PATCH 1/1] dmaengine: fsl-edma: merge mcf-edma into fsl-edma
 driver
Message-ID: <ZkOOSRMxX8MAO/3W@lizhi-Precision-Tower-5810>
References: <20240509193517.3571694-1-Frank.Li@nxp.com>
 <CAMuHMdVB2PrkxDMoo0y1y6SLj-yuW5o+PJ+sQn2VtB2yrXzkbw@mail.gmail.com>
 <bd538260-2403-4912-961c-549c74aead76@kernel-space.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bd538260-2403-4912-961c-549c74aead76@kernel-space.org>
X-ClientProxiedBy: BYAPR06CA0069.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::46) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DU4PR04MB10887:EE_
X-MS-Office365-Filtering-Correlation-Id: 096aa94e-5152-4610-e98e-08dc74312ec8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|1800799015|52116005|376005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TEZscnQ1QjZkclAxS2Y1Znh0djJXWExybFh1UGZuQzhoaXRhOTg5VG5IMEJv?=
 =?utf-8?B?V1FaZ002MHBuYUNLZW5sKy9OeEVuSjVCRUNZV0VEQ2hWc0xrbjJ1SXI0a011?=
 =?utf-8?B?RnhzS0luWVI2Wi9zSmJacEZ4U3NRZHJEeS9GYi91aHVoOHRBYnMvM0ZQS1RQ?=
 =?utf-8?B?ZnF3UjNlME1GaFFmRmg0Z05YWlRZYzBnTXRBRThUV3VOUlYwcFQvWFl2VEZr?=
 =?utf-8?B?M1dRZGhaaW10UWxYL2Jybi9ORU9OMzNxOEhPVDN4YXNCVVg2TDJuVVhoZFhD?=
 =?utf-8?B?YW16US92SzlsNkl2dFdhR1BxaldTR0RhUmRndEhWejM3UzUzWnZoUjlwa0Vj?=
 =?utf-8?B?NXVGaVdCcGlNRHdmTmh2UzhrRmY1aW9Wc2l2NXhVUkpCYS9BQjh0YU5wNUh1?=
 =?utf-8?B?Y01xK05FNlM0MXdsWlR3TlNrSk9RS0JLMlVVaGxUcmtwVk9OYmxGWUdKdVpB?=
 =?utf-8?B?Sy9yZ0pwWDZ0bkdrQ3dPcVl1MCtPVlJhQmlUbEUwL0laM1l2b3g3V0pKOWV3?=
 =?utf-8?B?S1dSMlp0MzB6UkJxNHVOYVV3TE5ITEk2VTJ1cVVTM1k2Qk54KzBWOTJDY0tO?=
 =?utf-8?B?NE45KzRuYzBid3JPeUV4T1h5blVnb1NyWkpQdWYzNEtWZU44ZVlobDNwaFhk?=
 =?utf-8?B?cVJQbkJ2RFZrNGtKdzZWOFM1cW5aREJuUmdudTY4UHh1OFVYNXJIU0N0Szlm?=
 =?utf-8?B?eEJGVmtsWVJDc3ZDVkJ2cTRYYms0VWZ1TTJobm13eDlBS0xEMlQ1R2NuakRa?=
 =?utf-8?B?dW1wOVAwcjFIREQ0ZGJZTGtWTTRKcjRobGZ4NVhaWWdmL0xTWlJ0a3NaSkww?=
 =?utf-8?B?WWQyMm9OUHFPQnA5SGNYOW91MUlNSGVUZmgwNThuMm8yanFJUjVUVmZDU3k0?=
 =?utf-8?B?akg4MlRreGNOazBaWDhuOG8wOEd3MTRkTDkwMUtmSUsrR0huYlNiTHFkR0t4?=
 =?utf-8?B?WjJrUE1IdWZnVHlYSUtUWEZoYStXZld3VW1VU1BMTGpUSkpSeUVSelRjSU9P?=
 =?utf-8?B?NVZMUUN0UXRUbFFsM29LZmdYTEpnRG5WZ1ZsalIyZG1XNzM0TWdCMDByK3hP?=
 =?utf-8?B?RG9wOEZhaHVMelB3RXA5bTVjb0xKWmpDRXJ6djNqN3Z1amI5T2RJYkJSblpI?=
 =?utf-8?B?azhNMkZVS3ErOG5GQVZ4UFJ3dkZUNktDTXQ2dFU5Ny9WTHY1SnpndjRQWjNy?=
 =?utf-8?B?ZWtPRlR2R2ppUDVSZXFGKzZHYmU3emRiNG5rZXc5algvSzkxS0E4RmYrNTRD?=
 =?utf-8?B?V0RLaGpQVHphY1d3NUpmYnR3c29SdXFOUFp2bHJNNGVBb0xjOFBCb0kvMGRk?=
 =?utf-8?B?S25WM2U3SHZYZWppVjFqeGJ5M2pXTks3d0J6NjRTTUdwS0h5M1hBcGJ1M1p2?=
 =?utf-8?B?aitRK2dKZU81SnpXMElPZzB1L2FWS1NsQVcxQVplSXMwNmdrczM2NjNobVQr?=
 =?utf-8?B?ejRnU0VaOE9ZZUtVL3ZrdkxrZFcyQ1ZsWlNIUzZFWVkxWWNLUFAyUlFsTldw?=
 =?utf-8?B?bVAxdHhOY1NFVTVBNTFFNDh3aS9lYjVRY3pSbkJUdUtLZDBzeTBKQXh4eU01?=
 =?utf-8?B?Zktkcnhab1YzaUZyV2ZsOHdIaThrZ1o1YlJnU3lMSmY2dW4ybnNDdUtkR1E1?=
 =?utf-8?B?ZG5hS1Z6UDdZS1ZGZTMrb0NDREJ5YTdXK3daZSs4eTYzdWVBUmpqOFllb2Vi?=
 =?utf-8?B?d3o3NEJyVUNIMHl1Yk84Nm1ycC9XTXZwdk1xbS9TaTU5L0pSWHhwanV3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(52116005)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1o3L3NEUEpML0l0Z0Npd2xpanZGR1dkb25lRVpRcHc1cm1md0FmMEFvd0N0?=
 =?utf-8?B?anBrVlpENHRIQ1ZmRncvU05xUXhiK1lTSEdBZEZvdkl1TEN5UjE3eVE4aTF6?=
 =?utf-8?B?T1BYZG9RT2xzUUFOeElveExac3Mvd2JscjBXU3JXdzNyUGVveWh1Q3Bsc0ds?=
 =?utf-8?B?VW10bkJEMW40czZFWlJDVkdkK2ROZWx3TGQwMEE1WWpSUWk5UmxkSVpubXlV?=
 =?utf-8?B?ZmdZZEY4SmxjaEVRRTFRLzhSYUVCMFpITjJmdVZxWkUvZ1NZaG9LMk5yOUtq?=
 =?utf-8?B?TGVTZWVlRW90TmtxZkRiTGJ2MFE4SVdqZ3hSU0JoRlM3QyttLzFkbStNdG16?=
 =?utf-8?B?M2xZQUhmQnZNekNUd2pMd2dHcWhSNklib0J5dEdWYW5QdmJSOU1JYmVWMlJD?=
 =?utf-8?B?QVhrQVd4Zmx4Q3dGdTBtUUhaNmcyNm5lSS82WjhncEVHUEI4ZW1kUlZ5V1Zi?=
 =?utf-8?B?eTdvMktJejFuMzJYTTdYNisvY0FObS84YlFkOHRIajFreGVZN2FUZzNSZzRV?=
 =?utf-8?B?QWpNcjZSNVNncno3MEJqSUFSblEyam1QWFRaL3VjV0xVc3BaTi85VDU4NXNJ?=
 =?utf-8?B?MExuR0RpY21MTjVOdHlkcFNrMmwrZXNJNHVnS25wcnhDaFU4dFo3Z1JuVkJC?=
 =?utf-8?B?TmF4MXp2cXlFNlgraVdHaUY4Yit1QWQvUDRaWHpncW9JNjlJTWdQUFpNWTJM?=
 =?utf-8?B?WWlxb1o1aEpRTzJvMnZUTTlVMHlySEF4RjVrVCtld2pkZFNYN0FzdVdsR3dj?=
 =?utf-8?B?eXI1d2hFOXZVendmR3BzUktHdUZxTWpRRHljQU8waVdVRFpzMzRGdWVqcUJD?=
 =?utf-8?B?a2VwU2I4UktrTzZ4dEhjaEhuTkRDUUpaYm9lUEhrQ2l5c0Jzd3h1M0swMUwz?=
 =?utf-8?B?d3NibERVZWVSTE5LZHBGakM0NW5sQnFDMzNiRENTUUJGb1o1YmNCWktYTnIx?=
 =?utf-8?B?dVZPK054SjMvNnMxVGN5ZXhJQUgvUTM5VWNYckt6TFBvRnlsM0tjNlpyVGJL?=
 =?utf-8?B?cjhyVEdzK3pGQ1lPeCt5Z3lCOXpvclVTTjQ5SGVnREpISWZGdE1iYVRaYjJz?=
 =?utf-8?B?WUNxR0sxVmJlRTdVS2RRbXRkQnNra2pudFpqeWZadjF6N0VHclFMcVdrcGN5?=
 =?utf-8?B?dXZ3RksxNW15ZzA2L0l1cHYzeGU5dHBFUk1ROTJmQ3p2MURzVGFTZUlXeE44?=
 =?utf-8?B?TXhxakdsZ3h5dzdScWFqVjEvK2c5aExvRDZEcUEybC9QaGZJSnpMWnRXY04y?=
 =?utf-8?B?SFlGNDYrVTM2MlZoV3RJNi9MbFY2Sk1LeVEyNE9tckJ4N2pKdHZwaTdKamww?=
 =?utf-8?B?eEFRbG1KYXBJV3c0WHVKZ1RmL3R0SkUzNnlGQ1RwYjNZK3RlL2RqWmduTjU3?=
 =?utf-8?B?SHN2ODlFcFNCUDJ6aDRYQWxJVHNvRDRoQ3p3Z0Y3L2h6QTl1NHZnRGxUbHNB?=
 =?utf-8?B?L1N2STlwVjZJQlZ3UGZ1cW1Nb21DZjJ4aWh1ZytWWGY2TnRrNFBNSGJYWlgx?=
 =?utf-8?B?aElCbzFkKy9xLy96Z2VVTDMrU3pPZitEY1NWb2s0clZNanZMeGNnSGdQblkz?=
 =?utf-8?B?YW5INERlWjdvdDdHSERmUzMwbld0V2JwZXRtUG1wZXZsbUtWVCtJQ1NzRWsv?=
 =?utf-8?B?djlBdUhNbVpMeTBoZzhha2pKMldkcnpxSUxveXlURER5SVVOUWFhblVYekRX?=
 =?utf-8?B?NXJXOEpRN2lINnBnOFNoYVFENFZ2ZWFrbXI4K0RNRjcrYllmWnNIZSthTTla?=
 =?utf-8?B?N0JqdEVYNU54OW9lL0lQUnBwS0xIZ0lJb0JXaWV0RlZId3dLY2dpb0pNcHlZ?=
 =?utf-8?B?bjRnUDlPVFBzUk94cThpa2taSzdVTG0xUjhYR3VFd2NyUGxXTVU3bkV3NWZi?=
 =?utf-8?B?SjRObkV2NVRBNmY4Smd2ZUphRFZXM0p4Y0ZNanNGUlRPdUZ0OVQzYVF3dk8r?=
 =?utf-8?B?dHNXREtjRllQaDA2Q1BJK294KzRJbkFFZk5objFGekRnMnJISnFmWVBTUzg3?=
 =?utf-8?B?NmExMzZLU0VBdU81V0podS82RXdCYzU0Y0NiUThYaUxSMGxEc29ndTRsdDdl?=
 =?utf-8?B?WUN4T0pzcWRYb1RiTTBzM0lYUzd1NjU4TjJ3ZnhuUlVlRlcvYWYyK25sWnFi?=
 =?utf-8?Q?0RJyP1yYvVKrB5FaYzxPU1+23?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 096aa94e-5152-4610-e98e-08dc74312ec8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 16:16:17.6372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jcNLYK2GTP7GT3hmp68/6m9iUYcXCmdeEjnYYi27vvdw8anv3soC1mjPE8jzTd7D84Hn3UDJRjP/qG9tptjeQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10887

On Tue, May 14, 2024 at 09:57:09AM +0200, Angelo Dureghello wrote:
> Hi,
> 
> On 13/05/24 8:12 PM, Geert Uytterhoeven wrote:
> > CC coldfire
> > 
> > On Thu, May 9, 2024 at 9:35 PM Frank Li <Frank.Li@nxp.com> wrote:
> > > MCF eDMA are almost the same as FSL eDMA driver. Previously link to two
> > > kernel modules, fsl-edma.ko and mcf-edma.ko. These are not problem because
> > > mcf-edma is for m68k ARCH and FSL eDMA is for arm/arm64 ARCH. But often
> > > build both at PPC ARCH. It also makes sense to build two drivers at the
> > > same time. It causes many build warning because share a fsl-edma-common.o.
> > > such as:
> > > 
> > >     powerpc64le-linux-ld: warning: orphan section `.stubs' from `drivers/dma/fsl-edma-common.o' being placed in section `.stubs'
> > >     powerpc64le-linux-ld: warning: orphan section `.stubs' from `drivers/dma/fsl-edma-trace.o' being placed in section `.stubs'
> > > 
> > > Merge mcf-edma into fsl-edma driver. So use one driver (fsl-edma.ko) for
> > > MCF and FSL eDMA.
> > > 
> > > mcf-edma.ko should be replaced by fsl-edma.ko in modules, minimizing user
> > > space impact because MCF eDMA remains confined to legacy ColdFire mcf5441x
> > > production and mcf5441x has been in production for at least a decade and
> > > NXP has long ceased ColdFire development.
> 
> when i developed mcf-edma, i tried to modify fsl-edma first. Modules are
> similar but there are various edma IP versions, and i remember minimal
> differences in the CF version too, some register bits and, of course,
> endianness.
> 
> If a merge is possible, welcome, i have here mcf5441x, can give a try to
> this patch as soon as i can.

Thanks. I am not sure if recent eDMAv3 and eDMAv5 patch impact mcf5441.
eDMAv3 is quite big change. If you can test on mcf5441x, can I send to you
a futher clean up for mcf5441x? This patch are just simple glue two
driver together to avoid a build warning. 

> 
> 
> > > Update Kconfig to make MCF_EDMA as feature of FSL_EDMA and change Makefile
> > > to link mcl-edma-main.o to fsl-edma.o.
> > > 
> > > Create a common module init/exit functions, which call original's
> > > fsl-edma-init[exit]() and mcf-edma-init[exit]().
> > > 
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202405082029.Es9umH7n-lkp@intel.com/
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >   drivers/dma/Kconfig           |  8 ++++----
> > >   drivers/dma/Makefile          |  5 ++---
> > >   drivers/dma/fsl-edma-common.c | 28 ++++++++++++++++++++++++++++
> > >   drivers/dma/fsl-edma-common.h |  5 +++++
> > >   drivers/dma/fsl-edma-main.c   |  6 ++----
> > >   drivers/dma/mcf-edma-main.c   |  6 ++----
> > >   6 files changed, 43 insertions(+), 15 deletions(-)
> > > 
> > > diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> > > index 002a5ec806207..45110520f6e68 100644
> > > --- a/drivers/dma/Kconfig
> > > +++ b/drivers/dma/Kconfig
> > > @@ -393,14 +393,14 @@ config LS2X_APB_DMA
> > >            It does not support memory to memory data transfer.
> > > 
> > >   config MCF_EDMA
> > > -       tristate "Freescale eDMA engine support, ColdFire mcf5441x SoCs"
> > > +       bool "Freescale eDMA engine support, ColdFire mcf5441x SoCs"
> > >          depends on M5441x || COMPILE_TEST
> > >          select DMA_ENGINE
> > >          select DMA_VIRTUAL_CHANNELS
> > >          help
> > > -         Support the Freescale ColdFire eDMA engine, 64-channel
> > > -         implementation that performs complex data transfers with
> > > -         minimal intervention from a host processor.
> > > +         Support the Freescale ColdFire eDMA engine in FSL_EDMA driver,
> > > +         64-channel implementation that performs complex data transfers
> > > +         with minimal intervention from a host processor.
> > >            This module can be found on Freescale ColdFire mcf5441x SoCs.
> > > 
> > >   config MILBEAUT_HDMAC
> > > diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
> > > index 802ca916f05f5..0000922c7cbfe 100644
> > > --- a/drivers/dma/Makefile
> > > +++ b/drivers/dma/Makefile
> > > @@ -33,11 +33,10 @@ obj-$(CONFIG_DW_EDMA) += dw-edma/
> > >   obj-$(CONFIG_EP93XX_DMA) += ep93xx_dma.o
> > >   fsl-edma-trace-$(CONFIG_TRACING) := fsl-edma-trace.o
> > >   CFLAGS_fsl-edma-trace.o := -I$(src)
> > > +mcf-edma-main-$(CONFIG_MCF_EDMA) := mcf-edma-main.o
> > >   obj-$(CONFIG_FSL_DMA) += fsldma.o
> > > -fsl-edma-objs := fsl-edma-main.o fsl-edma-common.o ${fsl-edma-trace-y}
> > > +fsl-edma-objs := fsl-edma-main.o fsl-edma-common.o ${fsl-edma-trace-y} ${mcf-edma-main-y}
> > >   obj-$(CONFIG_FSL_EDMA) += fsl-edma.o
> > > -mcf-edma-objs := mcf-edma-main.o fsl-edma-common.o ${fsl-edma-trace-y}
> > > -obj-$(CONFIG_MCF_EDMA) += mcf-edma.o
> > >   obj-$(CONFIG_FSL_QDMA) += fsl-qdma.o
> > >   obj-$(CONFIG_FSL_RAID) += fsl_raid.o
> > >   obj-$(CONFIG_HISI_DMA) += hisi_dma.o
> > > diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
> > > index 3af4307873157..ac04a2ce4fa1f 100644
> > > --- a/drivers/dma/fsl-edma-common.c
> > > +++ b/drivers/dma/fsl-edma-common.c
> > > @@ -888,4 +888,32 @@ void fsl_edma_setup_regs(struct fsl_edma_engine *edma)
> > >          }
> > >   }
> > > 
> > > +static int __init fsl_edma_common_init(void)
> > > +{
> > > +       int ret;
> > > +
> > > +       ret = fsl_edma_init();
> > > +       if (ret)
> > > +               return ret;
> > > +
> > > +#ifdef CONFIG_MCF_EDMA
> > > +       ret = mcf_edma_init();
> > > +       if (ret)
> > > +               return ret;
> > > +#endif
> > > +       return 0;
> > > +}
> > > +
> > > +subsys_initcall(fsl_edma_common_init);
> > > +
> > > +static void __exit fsl_edma_common_exit(void)
> > > +{
> > > +       fsl_edma_exit();
> > > +
> > > +#ifdef CONFIG_MCF_EDMA
> > > +       mcf_edma_exit();
> > > +#endif
> > > +}
> > > +module_exit(fsl_edma_common_exit);
> > > +
> > >   MODULE_LICENSE("GPL v2");
> > > diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
> > > index ac66222c16040..dfbdcc922ceea 100644
> > > --- a/drivers/dma/fsl-edma-common.h
> > > +++ b/drivers/dma/fsl-edma-common.h
> > > @@ -488,4 +488,9 @@ void fsl_edma_free_chan_resources(struct dma_chan *chan);
> > >   void fsl_edma_cleanup_vchan(struct dma_device *dmadev);
> > >   void fsl_edma_setup_regs(struct fsl_edma_engine *edma);
> > > 
> > > +int __init fsl_edma_init(void);
> > > +void __exit fsl_edma_exit(void);
> > > +int __init mcf_edma_init(void);
> > > +void __exit mcf_edma_exit(void);
> > > +
> > >   #endif /* _FSL_EDMA_COMMON_H_ */
> > > diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
> > > index 391e4f13dfeb0..a1c3c4ed869c5 100644
> > > --- a/drivers/dma/fsl-edma-main.c
> > > +++ b/drivers/dma/fsl-edma-main.c
> > > @@ -724,17 +724,15 @@ static struct platform_driver fsl_edma_driver = {
> > >          .remove_new     = fsl_edma_remove,
> > >   };
> > > 
> > > -static int __init fsl_edma_init(void)
> > > +int __init fsl_edma_init(void)
> > >   {
> > >          return platform_driver_register(&fsl_edma_driver);
> > >   }
> > > -subsys_initcall(fsl_edma_init);
> > > 
> > > -static void __exit fsl_edma_exit(void)
> > > +void __exit fsl_edma_exit(void)
> > >   {
> > >          platform_driver_unregister(&fsl_edma_driver);
> > >   }
> > > -module_exit(fsl_edma_exit);
> > > 
> > >   MODULE_ALIAS("platform:fsl-edma");
> > >   MODULE_DESCRIPTION("Freescale eDMA engine driver");
> > > diff --git a/drivers/dma/mcf-edma-main.c b/drivers/dma/mcf-edma-main.c
> > > index 78c606f6d0026..d97991a1e9518 100644
> > > --- a/drivers/dma/mcf-edma-main.c
> > > +++ b/drivers/dma/mcf-edma-main.c
> > > @@ -284,17 +284,15 @@ bool mcf_edma_filter_fn(struct dma_chan *chan, void *param)
> > >   }
> > >   EXPORT_SYMBOL(mcf_edma_filter_fn);
> > > 
> > > -static int __init mcf_edma_init(void)
> > > +int __init mcf_edma_init(void)
> > >   {
> > >          return platform_driver_register(&mcf_edma_driver);
> > >   }
> > > -subsys_initcall(mcf_edma_init);
> > > 
> > > -static void __exit mcf_edma_exit(void)
> > > +void __exit mcf_edma_exit(void)
> > >   {
> > >          platform_driver_unregister(&mcf_edma_driver);
> > >   }
> > > -module_exit(mcf_edma_exit);
> > > 
> > >   MODULE_ALIAS("platform:mcf-edma");
> > >   MODULE_DESCRIPTION("Freescale eDMA engine driver, ColdFire family");
> > > --
> > > 2.34.1
> 
> Regards,
> angelo
> 
> 

