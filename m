Return-Path: <dmaengine+bounces-3688-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C06A9BE305
	for <lists+dmaengine@lfdr.de>; Wed,  6 Nov 2024 10:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64BE61C20F81
	for <lists+dmaengine@lfdr.de>; Wed,  6 Nov 2024 09:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D899B1D5CFA;
	Wed,  6 Nov 2024 09:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="q/OPc6kc"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2040.outbound.protection.outlook.com [40.107.100.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084703211
	for <dmaengine@vger.kernel.org>; Wed,  6 Nov 2024 09:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730886531; cv=fail; b=dxJHn6hTfoG9/nl050Eg6Mz7lUBrfRd7bAzXrUTNliTAs7upCK4juFeuVxOIXszbMgIm/jTvqqjid0E0cT4tYo1Vj3XPBUEkiadNFCRLdwwRVk6Q0eIRrosYinDc8YXBu2qTxaLAci54r28E1e9o5bJ6DQyuAi5swHgn+9UEkAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730886531; c=relaxed/simple;
	bh=WiARj/m1dMLvkTfT4i69rhCokVevv+eqKJj9atfSlkI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LqRqAWU6pSMnCpL30FWNz2iKLrgruTYCEAvpd578qvsb+Rk/K0ZZ6y0+E7P8eVaz7W1pYhxHE0zzOTOXbHa3Jr8LwJEDXSLhHNxmm2iGuJ20jm5UkBQonRE2m8w1AULqTKWaS52YU5Lpi8J9sTxyHvMfhNwvbYF8wSh8JX3f1iY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=q/OPc6kc; arc=fail smtp.client-ip=40.107.100.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qMxucysfgdAcAdpHf0rXr9UgywT+nU9ab2MXv1a8e3ctwzVdvw5gn2abKD3+P8RKHuqoRbihr8hrbV2CFcbC8L0rMi1XZkKO+3aKxj59JrMhEqWdzl4MhVHo2D168xPWid3OOu4WDiFcuNVNY6jBPKxJ6gZLN0ARottQb+NRJE+Jet5dGMicgTOENx2MYIWZjjr9fcD6houRIUz7jkWXA9//IJBdwM2HGI/2K2uL2NdGrtykThQj2q6tDe0AE0KArvW/1Z6NCYo9MOlBRQSavSHPh3JKbRgRmL+/KK3s/gouuyCWMiQ0Rk+wGfc+JwSd1mD0Opj++u8U5P+4MntsRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WiARj/m1dMLvkTfT4i69rhCokVevv+eqKJj9atfSlkI=;
 b=w4KrbIsqL6i+wxwrDh+txH9lILgFlhX6KVcvOmklX1ykJoYY35lrZfmn0cwmxo96q2KKPgpyo8/Lug41zcSv1jVinASTQSUCfxo9smqKVKKozs+GSECr6EVajyYVr7G2i1OQhb7vlGC41g6Va3UEYzej/BgkAIcMuF9gocP+OZZcW9HnZx4g4nK8C4eHnQIgpeXf9HDpIuF8RyahBxl0jHolq+m0y4KM/VQCQCR7BAWs9mpZFgcAVJH7Gb4Me7HbCpvhGvl/M51CHQh8UsshM1HyD2jIN6NdywOf1qK/Vh0y1XCPDY+Y5XN2kJ2MVG2aZrq5yKEFQrrTgGt9w1TLAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WiARj/m1dMLvkTfT4i69rhCokVevv+eqKJj9atfSlkI=;
 b=q/OPc6kc7qK8FGZkuwgUBzR3ZDHbkldB4GWIW8Hx5hLp6vZmNvVhhWffzkhMq4+Tq5hiVGysfKW1luvCL8cvtx/9NuBljkux7ynIWAwp1XWgZlC8m5wK7dnkUOBMVyWhghtuc+jZAZsgjXAyDfoRwDA3XKyBw/fsFKMdXep0mI8=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by DM3PR12MB9286.namprd12.prod.outlook.com (2603:10b6:8:1ae::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Wed, 6 Nov
 2024 09:48:47 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c%4]) with mapi id 15.20.8137.018; Wed, 6 Nov 2024
 09:48:46 +0000
From: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To: Marek Vasut <marex@denx.de>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>
CC: =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@baylibre.com>,
	"Simek, Michal" <michal.simek@amd.com>, Peter Korsgaard
	<peter@korsgaard.com>, Vinod Koul <vkoul@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "Katakam, Harini"
	<harini.katakam@amd.com>
Subject: RE: [PATCH] dmaengine: xilinx_dma: Fix freeup active list based on
 descriptor completion bit
Thread-Topic: [PATCH] dmaengine: xilinx_dma: Fix freeup active list based on
 descriptor completion bit
Thread-Index: AQHbK7YsIMHqB+OYBEGVEmCGVyTwsbKqCNFA
Date: Wed, 6 Nov 2024 09:48:46 +0000
Message-ID:
 <MN0PR12MB595370521C2E3D61145D15BCB7532@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <20241031165835.55065-1-marex@denx.de>
In-Reply-To: <20241031165835.55065-1-marex@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|DM3PR12MB9286:EE_
x-ms-office365-filtering-correlation-id: 86ce3dd7-48a0-4976-de00-08dcfe48358c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SzJ4Sjc3blo1WGVEQ1luYnRVMGM1ZGlOOHljcEorcnExQ09NY05GTmVRN1lj?=
 =?utf-8?B?a2tLWGlOQU96TEpXTDN2WUhzMEx1Uk15c25GWEoxUWl6Q2R3THFuVXVQVkJh?=
 =?utf-8?B?WTJsZDYzSVArQkhlQWt1VkpZU0pqemRIbHVuMUk5akRRMVIxLy83dnpIM0xT?=
 =?utf-8?B?UDJRNFlZKzRuKzUvaENuSEVlYkxUZURDYjljSmpGZmVTQy9BcVYxRjk0aXpR?=
 =?utf-8?B?bm1yNGp3aHR5OEh4bE0wUW5NaVB2bmFzNno1bk5nZlNuemJPS1RqRlhrUGRy?=
 =?utf-8?B?WTFGS3RlSWtITm5yMUlZeWxkY05YeGUvMGtiTk53YTdTaDBvY2tPOGw4ZXEx?=
 =?utf-8?B?UHJDOWJOQlhiQXJOR3FhNnY0QURmSSt0cXIzQzdIckcwajBBaFY4b25qNTRY?=
 =?utf-8?B?ZExsYldFTmdtd25VY2xFQU1IeVdFeVVwcGpFaXFkUjRRZkxKNGErRFI5SmtH?=
 =?utf-8?B?MFR0WjBBeHFjWkl4L3AzcXY5Tk9XOTl3NFBXVVZ5NDVTUTNtUDAwWnh5VTBr?=
 =?utf-8?B?Mm0wNDArTWVaYXQyWSs1dGIyeDQrN0JlNzg2R3diaHI3UUlTUDdoU0NXbWRM?=
 =?utf-8?B?WFhWS20zbVVzdkZqUTgvVjZZanpMUnFxQkhOS1ZLYlprNHBSZEtRRjdmTDRM?=
 =?utf-8?B?OFVGSkdYWVY0Rm43MHA5ZHorVlEyZ0hkNTNKSzB1cXo1WmlDUGx5RWRSTmQy?=
 =?utf-8?B?aVBPaGh3SHlQQjQwQWRtRmVIcVNBTkZWRnpIdmNYaDB0SVRHeSt5K3RuQStG?=
 =?utf-8?B?TjdJdmszdDUxSlJjbzdkbHczYkxVNmtqSG1tczViV2VNRG5zM3ZpUnJjUHY2?=
 =?utf-8?B?K0M4bllaSXpqVFFObTZlQlVHMjN1R0Fva05FQTkxaWhnT3hxMjk5SWlIZEZs?=
 =?utf-8?B?TmsrQ2dBczFmYnpXSmw4QW5GdVdYRi94NXlWbUM1aWttKzdNZnFmWi9iczRS?=
 =?utf-8?B?QW85elI5RTkvUXpZRCtSVzh6ZkxLbGVSeFZOL1I0eG5PWTV2VDlNNmt5SWJ2?=
 =?utf-8?B?SGpKTzF0TllaV3hxOVRvZEVkWUdmSVdZazRQcUR2ejBzTlVZaW1sL3EzQ1V1?=
 =?utf-8?B?bk8rY2ZkaFhDVld3M0wwN3pQS1RTeTZsNWFxVW1YMlQ3RXloaTFUdFhWc04r?=
 =?utf-8?B?VTdxd1JOUmtSTXRNOEpNWC9uM0xsWWp4Zk5IM2hUU29Ndy83ZjVsRE82Nlpx?=
 =?utf-8?B?ZEVxNmw5VitXM3BoRFZ2akJkOW5vZjRjTHNzVHUra1JwYTdPdDJ5bzBnMHZB?=
 =?utf-8?B?TWtKdzlJZVp6cWtJK1RPNGkxVk9pSWRldGhmK2hnS3NnUjlzWms0Ry9tNGJS?=
 =?utf-8?B?a1I1UGFoSUtWUWxxdXNERzlQR0pWbWtjdStqOWxZNVBLbzRkcTI3YmtnQmpY?=
 =?utf-8?B?NHAwcU5sbHZ5bzhLeEdxT25sV3gwa25RalJqTzlaVDNEZmEvVm1td3BQbGQv?=
 =?utf-8?B?bXZlSm9IZ2hmdzN1bUtqbjcyMHhJR0d5S3RaTkROLzByejUxOEhzV0VBWlhk?=
 =?utf-8?B?alRJVGhrRGFQOHBzcDFPUTJaRUNLTGVNL2pPd0taTzdNNGlkcXBORE10WmxK?=
 =?utf-8?B?UUpKKzRkVGJaN1Y4cUNQL0JIMkpGRHlDWTVtTXpBMXZpS1BxOUtqUGU1enk1?=
 =?utf-8?B?Sjg1bUUxWlJkR2Fkd0ptZ1A0R0JrZzJRWnlONzhHT0g2S210Y3I5bFFhSWdP?=
 =?utf-8?B?ZlpVYjlNU2dFMkVHc1RFczIvM1RoTmh4elVoU0ljOEtQbk8vdXJBK09lYW40?=
 =?utf-8?B?RWpCYThrM0dqWS9CeTBUeUFESzlab0YxVFRURFpvYXRIVWx1aHNwSlBCRjVQ?=
 =?utf-8?Q?Zs7Ktl4mNnNzRW9P/WHx0TD7WrcSo8pJM1HaE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TWJSNVhFc3ZmVkFSSDNpTmZhakRVajBIb1ZnOWl1MHBwUVJuWmxhSUozK0Rr?=
 =?utf-8?B?NlJzcHJkQmViWURYYTFJemtoK1lKeS95L1JINUs4MnVISTRWNXpmOWpuZUQ4?=
 =?utf-8?B?RjdENEcxTVZlSi9tZS9lcHZCc0VyZkJaVU1wallGWnNFNHQyeGNDbGNTMWRa?=
 =?utf-8?B?a21IaEpzOGZqQUh3dFBJSmtnbVQybVBZa3RJL0hnMmcxaWRocjhpVkN1Uk1Y?=
 =?utf-8?B?WURNTk5ac3lJWGVjblNUaE00cG1NUzZLZnNNajk4MUhGVVh0UUdNQS9SRmt0?=
 =?utf-8?B?TFFKU0w1cTcyTUNmNjk1ZUlLbzd2NThzdWdneGtDeXQwR2tVbm4zdlNIU2pH?=
 =?utf-8?B?QVNRYXVXRmdITWdod0ZmQUZzR2E5cmJCelUrVVVJMVgyR3lxMmRjZE9NelA5?=
 =?utf-8?B?Wjl5K3ppdHBmSVJmSmVBQ0NCR2JqNHpLa2lqbm12TnRjUW5yOGdyRVI0ZXRD?=
 =?utf-8?B?WWp2ZitMOVlZa3A3UmpkeUlYYU9GSEdyYmdwY3JuZngyZXY3NmJzckF4eUFr?=
 =?utf-8?B?ZkZ5UFp3MmtaaEh6ODZtQ2NZclFSd3FWUjlRdzl6c0w2VlY5Y0xCaytycDhN?=
 =?utf-8?B?RU1CZUtSaWRSTXpJR3Y3dEROSitQWnN1M2g3L2xhb1NobnlXVDVsZ3Vra3lm?=
 =?utf-8?B?T2ZDWWlJSTU0MTVvMXlJZGV3S2VOZE05UVR2OW43TFBUVm1WQm1pTGNFOVFa?=
 =?utf-8?B?Zy9za0Q2YXF3d0l0b1lzWU1OOTZJZ01URXBPUVFBTDR3ZUp2Wm5tNkFZQks2?=
 =?utf-8?B?VGFyZTJPQ1psU1h3OS9WRnFyNFdwYnRjNVh2Tzdld2FrSVA0U3czUzVvNDhZ?=
 =?utf-8?B?cDlDeko5dnlWM2wxVkJpT0NaSVBxcTdEaS9lWkZaanBFTEtrSVJXK3RGQkx2?=
 =?utf-8?B?QkhXcDM5K2h4c2QrME9oQUk1RFUxcmFyamFBV3IrSVFjWDNhbnNiTDRJRmpP?=
 =?utf-8?B?KzUrVmdXUFNsSUpqSkNnM3diamdqTmxUcmVrZjhTTDdXN1B5bFBqcEl1L3Z5?=
 =?utf-8?B?M2FFM0JIM2hFTm9WSjczSVVTTmVGMmIxMWl0RVFpenFXUDhJOTN2NVFaNlM0?=
 =?utf-8?B?ZnBJMGR3VXpYR2cxaVJqcVUwRnVLTVVRVGJpVk1WcDhKWlFmZ1NEOGxvUGxH?=
 =?utf-8?B?ZzM1aEdIMlIxNURPamZBVUxFTXora0g2NGp4MEgzc2k1M3JqdEVQeVhCYWNE?=
 =?utf-8?B?VlhLRzdVSjV3MHFqajRZbW1XZUFrd2hYSjc4RTdGNlM0SlhsY1NuUGJoZFF1?=
 =?utf-8?B?NEJCWFNTRm92d1B5UHJSWGNVdWhHQTFvRXZBWWNicnp4KzhPR3NoaXhCR1NI?=
 =?utf-8?B?RWF0eTlPY25POVlEU1NFa2t1ck15ZXk3eGNjVmFKMmpxTFl1WHd1OW9qalpr?=
 =?utf-8?B?UVFyTmVqVW5KcTBPM2l2bVdTNU93T21uSVNiRFVseDZiTkpXWms3cXVkcGpy?=
 =?utf-8?B?QXhMYjlZdUJrOGhQRVdnRHZrV0FObTVxa1ZsRmpzdGlaWG1RN2g2N0h6T0Zs?=
 =?utf-8?B?ckNGTmFIS3VqRzk3N3BHVzJxWjZJVDg2RFoxWTdMd2hRL080RGNGc2l6SXdW?=
 =?utf-8?B?UUtYbmRySE9CNmJHNE1tK1UyVkU3ZXJ5NDF6NWVqQ0pLTlVnd1hRRmFicElC?=
 =?utf-8?B?dXlrYTdPWGFoemp3QkVieW1LeVZuRGVSUHVqMVlqMkZtM21PMWYxV2NJRmdo?=
 =?utf-8?B?TFpQK1N0Ny9DM3JTVk1rUWZRd1ZwbUxFSitKOUNrS1VZUDUrRHZzNndNdGNH?=
 =?utf-8?B?eExSTTJ1ZGEwZFdWS3E4amZ6VGo3QWFWWGZFL1RhckFKd2d5VThsSlg0MUsx?=
 =?utf-8?B?SU1FbXBBM2xmRGd1QjQ1NHdiU2xKbzErblJ5VDlUUUhya05WMGx4bXhFRG9x?=
 =?utf-8?B?b1NVQUhoVlBEdHhuTzZXMVBvcHRNMkRqME5sK2JaMXVuWGJYOXZRTmo3d0xi?=
 =?utf-8?B?YU9NY0l4aTdwMGN3Z2tiNjNIYjYrck1jYnZqTUF1RjR6VGlVSnBudWlaYUhr?=
 =?utf-8?B?T0dJK091UzV5UTIrQmNvdURqUnJjbFNNM1NzVEJKZGQzUnlQbk5KdVhzT1pF?=
 =?utf-8?B?bXE5dUM1Ty9DNWRJWnhIUGJMKzFJeEl3dUhKVkJ5OTFHSDBuRDkrRGROSVFK?=
 =?utf-8?Q?CrEQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ce3dd7-48a0-4976-de00-08dcfe48358c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2024 09:48:46.9003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0G5ZmXxnxJMbfeEAeDzCMABZjBMea7Outt8jV/teeNe7NdECavduTQFzl0zHXGwS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9286

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJlayBWYXN1dCA8bWFyZXhA
ZGVueC5kZT4NCj4gU2VudDogVGh1cnNkYXksIE9jdG9iZXIgMzEsIDIwMjQgMTA6MjggUE0NCj4g
VG86IGRtYWVuZ2luZUB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IE1hcmVrIFZhc3V0IDxtYXJleEBk
ZW54LmRlPjsgVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLQ0KPiBrb2VuaWdAYmF5bGlicmUu
Y29tPjsgU2ltZWssIE1pY2hhbCA8bWljaGFsLnNpbWVrQGFtZC5jb20+OyBQZXRlciBLb3JzZ2Fh
cmQNCj4gPHBldGVyQGtvcnNnYWFyZC5jb20+OyBQYW5kZXksIFJhZGhleSBTaHlhbQ0KPiA8cmFk
aGV5LnNoeWFtLnBhbmRleUBhbWQuY29tPjsgVmlub2QgS291bCA8dmtvdWxAa2VybmVsLm9yZz47
IGxpbnV4LWFybS0NCj4ga2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gU3ViamVjdDogW1BB
VENIXSBkbWFlbmdpbmU6IHhpbGlueF9kbWE6IEZpeCBmcmVldXAgYWN0aXZlIGxpc3QgYmFzZWQg
b24gZGVzY3JpcHRvcg0KPiBjb21wbGV0aW9uIGJpdA0KPiANCj4gVGhlIHhpbGlueF9kbWEgaXMg
Y29tcGxldGVseSBicm9rZW4gc2luY2UgdGhlIHJlZmVyZW5jZWQgY29tbWl0LA0KPiBiZWNhdXNl
IGlmIHRoZSAoc2VnLT5ody5zdGF0dXMgJiBYSUxJTlhfRE1BX0JEX0NPTVBfTUFTSykgaXMgbm90
DQo+IHNldCBmb3Igd2hhdGV2ZXIgcmVhc29uLCB0aGUgY3VycmVudCBkZXNjcmlwdG9yIGlzIG5l
dmVyIG1vdmVkIHRvDQoNCkkgd2FudCB0byB1bmRlcnN0YW5kIG1vcmUgb24gdGhpcyBmYWlsdXJl
IHNjZW5hcmlvLiAgSG93IHRvIHJlcGxpY2F0ZSBpdD8NCg0KV2h5IGlzIGNvbXBsZXRpb24gYml0
IG5vdCBzZXQgPyBCYXNlZCBvbiB0aGUgZG9jdW1lbnRhdGlvbiBjb21wbGV0ZWQgYml0DQppbmRp
Y2F0ZXMgdG8gdGhlIHNvZnR3YXJlIHRoYXQgdGhlIERNQSBFbmdpbmUgaGFzIGNvbXBsZXRlZCB0
aGUgdHJhbnNmZXINCmFzIGRlc2NyaWJlZCBieSB0aGUgYXNzb2NpYXRlZCBkZXNjcmlwdG9yLiBU
aGUgRE1BIEVuZ2luZSBzZXRzIHRoaXMgYml0IA0KdG8gMSB3aGVuIHRoZSB0cmFuc2ZlciBpcyBj
b21wbGV0ZWQuDQoNCg0KPiB0aGUgZG9uZSBsaXN0LCBhbmQgdGhlIERNQSBzdG9wcyBtb3Zpbmcg
ZGF0YS4NCj4gDQo+IElzb2xhdGUgdGhlIG5ld2x5IGFkZGVkIGNoZWNrIHRvIERNQSB3aGljaCBk
b2VzIGltcGxlbWVudCBpcnFfZGVsYXksDQo+IHRoYXQgd2F5IHRoZSBuZXcgY2hlY2sgaXMgbWF0
Y2hpbmcgd2hhdCBpcyBsaWtlbHkgc29tZSBuZXcgYml0IGluIGENCj4gbmV3IGNvcmUsIHdpdGhv
dXQgYnJlYWtpbmcgdGhlIERNQSBmb3Igb2xkZXIgdmVyc2lvbnMgb2YgdGhlIHNhbWUNCj4gY29y
ZS4NCj4gDQo+IEZpeGVzOiA3YmNkYWE2NTgxMDIgKCJkbWFlbmdpbmU6IHhpbGlueF9kbWE6IEZy
ZWV1cCBhY3RpdmUgbGlzdCBiYXNlZCBvbg0KPiBkZXNjcmlwdG9yIGNvbXBsZXRpb24gYml0IikN
Cj4gU2lnbmVkLW9mZi1ieTogTWFyZWsgVmFzdXQgPG1hcmV4QGRlbnguZGU+DQo+IC0tLQ0KPiBD
YzogIlV3ZSBLbGVpbmUtS8O2bmlnIiA8dS5rbGVpbmUta29lbmlnQGJheWxpYnJlLmNvbT4NCj4g
Q2M6IE1pY2hhbCBTaW1layA8bWljaGFsLnNpbWVrQGFtZC5jb20+DQo+IENjOiBQZXRlciBLb3Jz
Z2FhcmQgPHBldGVyQGtvcnNnYWFyZC5jb20+DQo+IENjOiBSYWRoZXkgU2h5YW0gUGFuZGV5IDxy
YWRoZXkuc2h5YW0ucGFuZGV5QGFtZC5jb20+DQo+IENjOiBWaW5vZCBLb3VsIDx2a291bEBrZXJu
ZWwub3JnPg0KPiBDYzogZG1hZW5naW5lQHZnZXIua2VybmVsLm9yZw0KPiBDYzogbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IC0tLQ0KPiAgZHJpdmVycy9kbWEveGlsaW54
L3hpbGlueF9kbWEuYyB8IDMgKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9kbWEveGlsaW54L3hp
bGlueF9kbWEuYyBiL2RyaXZlcnMvZG1hL3hpbGlueC94aWxpbnhfZG1hLmMNCj4gaW5kZXggMWJk
ZDU3ZGU4N2E2ZS4uNDg2NDdjOGE2NGE1YiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9kbWEveGls
aW54L3hpbGlueF9kbWEuYw0KPiArKysgYi9kcml2ZXJzL2RtYS94aWxpbngveGlsaW54X2RtYS5j
DQo+IEBAIC0xNzE4LDcgKzE3MTgsOCBAQCBzdGF0aWMgdm9pZCB4aWxpbnhfZG1hX2NvbXBsZXRl
X2Rlc2NyaXB0b3Ioc3RydWN0DQo+IHhpbGlueF9kbWFfY2hhbiAqY2hhbikNCj4gIAkJcmV0dXJu
Ow0KPiANCj4gIAlsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUoZGVzYywgbmV4dCwgJmNoYW4tPmFj
dGl2ZV9saXN0LCBub2RlKSB7DQo+IC0JCWlmIChjaGFuLT54ZGV2LT5kbWFfY29uZmlnLT5kbWF0
eXBlID09IFhETUFfVFlQRV9BWElETUEpIHsNCj4gKwkJaWYgKGNoYW4tPnhkZXYtPmRtYV9jb25m
aWctPmRtYXR5cGUgPT0gWERNQV9UWVBFX0FYSURNQQ0KPiAmJg0KPiArCQkgICAgY2hhbi0+aXJx
X2RlbGF5KSB7DQo+ICAJCQlzdHJ1Y3QgeGlsaW54X2F4aWRtYV90eF9zZWdtZW50ICpzZWc7DQo+
IA0KPiAgCQkJc2VnID0gbGlzdF9sYXN0X2VudHJ5KCZkZXNjLT5zZWdtZW50cywNCj4gLS0NCj4g
Mi40NS4yDQoNCg==

