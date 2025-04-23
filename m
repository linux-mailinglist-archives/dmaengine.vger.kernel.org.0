Return-Path: <dmaengine+bounces-4997-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A73CA98AED
	for <lists+dmaengine@lfdr.de>; Wed, 23 Apr 2025 15:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC9FA3AEC11
	for <lists+dmaengine@lfdr.de>; Wed, 23 Apr 2025 13:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F00C15DBB3;
	Wed, 23 Apr 2025 13:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="NRqDjjk0"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010009.outbound.protection.outlook.com [52.101.229.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F8C148827;
	Wed, 23 Apr 2025 13:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745414810; cv=fail; b=VJm+sEif0qUZPV2Np/qycUP7Sg+9GBCA0OhwEgLryzC8blA+j8Uc+jqKezJY27vnbSzKkDpLL0InWNqOhZxVqHrwUH8J7JHo5neFkwrGy2Di7D5MDbYw1Nl9hXRKD5OdU4lvEPTWyWBMl+ott7MYe/Dre4huMVIHAGNh4aEYCqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745414810; c=relaxed/simple;
	bh=f1X2bg79n7g/688hnEEdSExGZ4Z/rjC2FF+nnJRMTyw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ht5hiqGvEsrQowdtEV923SthYJ8A6YmrOCNpusitCuW/8DUXpMG63FGpxmedxZ+M5b5ZqeJpxU6yuzgpAqR/VxfBhp6MCxiZTfXC0GaUCeC1IOwM8C0FY4W1/VabS4gXXpCqZLR9P4rl4EbB7IF4SQnk+h60+o24o3OVzJChllk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=NRqDjjk0; arc=fail smtp.client-ip=52.101.229.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KME7bjl36LOg5RnwAlKPBvg/0/FCJVciuPLuwk6y1wP3dvbm6Mya4YIrUZc06AtRQByjUcLQCzx1b8ZmfL88ueJ9jQTthjYk8EI90bQ0TL74UDv5fh26TnzF5ReNKhfDiO5N4gGjur98DCXyJrctdDrvmh4klqPKK806zv9XWad/HD5QsIjeO2Lthko2nrlDLXaWYzuOw5TsP7PdvNcpdHC/1Dasp2jEY4vJ2rKKH997C3CDwviayZFBOYxTHyfPt5hF/FpSvII81BBB6kMXWiG4NZXSAh7Pn5FvMDhNqHlJS1A0nTNM3y/MWxA52WLrRcxVqB3GjydKhvNME6oIIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f1X2bg79n7g/688hnEEdSExGZ4Z/rjC2FF+nnJRMTyw=;
 b=SOqlkTnnJP6ZhPVXq4xBink9XJ+a6hKj3IclD+yGf0eZOyOXd8n3SFDZXS42DHtPmhLkexqWiYwkxU6F90hIll93Ck7Ros7kTHS/cizgYlRtI3wu9ac05rOGHXaXiRAO4Q3Jb5o2HjkLT5speDLFu++i3/cR3ylTKBPQXKCJbvRQXwDbxcfYnMNPaBpt4iDmCAlqvW8V5EJVsyLtkRxqydWgzY7Q60C+/+67aWpjyByJFUrJfQIlnI7QCozPac3tzqHj/I8y4Tj8BEWjM8FUrZ1NG8fvOF1h9j1nEP4SzfutZpQtV7VcLukXcBOZYOczypLM7bUmqR/s59g2rnY7FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1X2bg79n7g/688hnEEdSExGZ4Z/rjC2FF+nnJRMTyw=;
 b=NRqDjjk01JRofEwfutWiIkW/+xLSVrKP0WrTVV8t9KJH8M31UJPu1Ul+WrC+V5++qsURbRFP3ft7NnPzLPsMlUFo5LEaV9o18i+r3JMZRzl/IDqx0c9go4e17ZHMMwDcLFlBogG86CIPVaMJadMTmFSre6/CDkzndpPsFAaF2vQ=
Received: from TYCSPRMB0009.jpnprd01.prod.outlook.com (2603:1096:400:18f::5)
 by TYRPR01MB13573.jpnprd01.prod.outlook.com (2603:1096:405:18e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Wed, 23 Apr
 2025 13:26:40 +0000
Received: from TYCSPRMB0009.jpnprd01.prod.outlook.com
 ([fe80::8f8f:14d6:a759:4c66]) by TYCSPRMB0009.jpnprd01.prod.outlook.com
 ([fe80::8f8f:14d6:a759:4c66%6]) with mapi id 15.20.8655.033; Wed, 23 Apr 2025
 13:26:40 +0000
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Conor Dooley
	<conor.dooley@microchip.com>
Subject: RE: [PATCH v6 2/6] dt-bindings: dma: rz-dmac: Document RZ/V2H(P)
 family of SoCs
Thread-Topic: [PATCH v6 2/6] dt-bindings: dma: rz-dmac: Document RZ/V2H(P)
 family of SoCs
Thread-Index: AQHbs62QelOf9EkojUWhlKcW69kenrOxIMSAgAAeErA=
Date: Wed, 23 Apr 2025 13:26:40 +0000
Message-ID:
 <TYCSPRMB0009EAE305A3BC54E74D4A5EC2BA2@TYCSPRMB0009.jpnprd01.prod.outlook.com>
References: <20250422173937.3722875-1-fabrizio.castro.jz@renesas.com>
 <20250422173937.3722875-3-fabrizio.castro.jz@renesas.com>
 <CAMuHMdUKVDzLUfcr_0R_VQ0TzBtPWGVbwfX_pKbwOjzuaBLcEw@mail.gmail.com>
In-Reply-To:
 <CAMuHMdUKVDzLUfcr_0R_VQ0TzBtPWGVbwfX_pKbwOjzuaBLcEw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCSPRMB0009:EE_|TYRPR01MB13573:EE_
x-ms-office365-filtering-correlation-id: 0b9a9835-6499-45d1-52b1-08dd826a7b6a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MzFheHlGUm9qM0VlRVJQT1BoQTBXSjd0RVFpM2VoWElOWVk0OGpmc25RaCtJ?=
 =?utf-8?B?eGlqZXhkQlozd1VXSFZUN3NIa29RNDBmSmRUV2tidkk5bjFud0JwbFBLUUFu?=
 =?utf-8?B?NFRNM2hWNFMrTUdvMGo3bncxOURrdFczNWl5NE5RSDY4REJIVHpqUUJjcFRQ?=
 =?utf-8?B?TmRsMktDL0dVQXJmMmgxQlNqR3hrWWVVRS8xU2hzeTdVQzlLZ2hlSHllTy9D?=
 =?utf-8?B?UTJhbE9vTldBRGJGZG5GVWdYU0V3cXhTWE5XSmRVR2JoNklmcGs4MHl0a3VO?=
 =?utf-8?B?akZCYzV6SUpWcG5Zb3VUMkVYOHQ4QmY2U2JyV0dxWmg4cUw1bWtObGtoeHI3?=
 =?utf-8?B?elUrMDN4dlo1bXJFcGlBTW1ROXZ6QTl0QTl4L0VpK0p0VUtFWHFLQ2ZTMS93?=
 =?utf-8?B?eUl6d1hRdlUxRGJWV1NNclltTmVEdVRMWUUva0U1K3Y3UUZkUkNHSWpXdTN4?=
 =?utf-8?B?N1dqVi9tNEZHaityWjVZWFR6anB2WlduRTgzSjNRRHRWMVBNZkZOZjZHRzdR?=
 =?utf-8?B?aEZhU1huTjF4c3o2NnVrRlRJRWVVK01pMHJkc1IxdmVraTNyZStwOWtvUTVI?=
 =?utf-8?B?RVQxQXBhQVIrNnQyUTNkSXNBbzhVQURqSmhyOTJEQWJ0SkE1K2xKK01XaWQr?=
 =?utf-8?B?Qkl4QVpPNGU0WUlLMVdCYzJpYXRKQ3Job2k2anY2L2E4ZmduTmVOdEZaSGMv?=
 =?utf-8?B?dkViNngrREZLUFcvYThjQ0p2SlUybjFQWmwvZnQ5Y1VOZjVmdStQdi9MSGdk?=
 =?utf-8?B?REplT0doclUxVThzSzA1VWc5WGdld3lCSWt0RGJMRWdtWVlxNDg3TUhONXJn?=
 =?utf-8?B?NEJuQnFRWk81ZjZzV083WG0vdktYMnBkYi9yd1N6b0xOUjgyTVRObkd2L2ti?=
 =?utf-8?B?b3BzNlBIWUhib096dzZHNGF2bEpFM0xMNmM4UWVicEhaK1JBeGlrcW5EMUp3?=
 =?utf-8?B?dFpzdlU2VmxsSmJ5cGJCOG1LcDVuQkJ1UjVpOVZnTmZRbVJJTHVmNEVxTzN0?=
 =?utf-8?B?YU1jNnhHNFlRNVN1dnA4aXdvUGxNUXE1aHVqU1FVc0FGbjh0dVZNUS9RalFF?=
 =?utf-8?B?ZThnMU1kV3A4S200TXhHQWJ0ZThnS3g4NGZRb2NXWVYxdG5KcERBZno5L1da?=
 =?utf-8?B?MEQ1RlBGVGxSb1EyR2tmbHpqclV6bE1jV08xYmkvRnY3enhmbGpLMnlHaFNE?=
 =?utf-8?B?QTNtZlZtZkVjTHljVGNhUFVXMHhVa2I2WnpCYWlzOWtTMFNpLzFHaldFZWd0?=
 =?utf-8?B?WXRnQlFyc2QxbWRiZmZta2FucTJOK2FJTmV6RWZDOHFWdG5IV1Z2d0FSTEFZ?=
 =?utf-8?B?dXhZZURMbUlpTGNoY1lKRDFKdlBOcUpSZVFnZWRFNGJjZU1FR0dmTS9lSlNS?=
 =?utf-8?B?bkpEbWNDYW5PTmxseXBtT3p1cEREcURkck02aHdSN0w1dlltR1FlVjZkemRH?=
 =?utf-8?B?ZDBURC9GQ09hcElNVUtyUk5PcG1KaDJyTlgzaEI5bmZoaXBhMXR3d2lWaEs0?=
 =?utf-8?B?YWVnaC9vdDJ5VmVYWkhvUFNvck5JeXZNNmVMQ1JNZi9LckhYaU1mQ09BelZT?=
 =?utf-8?B?RkNKODBlaEZwN3FURStVSUtCNDRxREpodjVkMHgxWGxERm42b0h2K2hiUDNW?=
 =?utf-8?B?MU8zbzV1TWVORU5HU2M1MXg4WDVpTi8reDNaL3VXVnAxeGtJcmtISElVNDc0?=
 =?utf-8?B?MDVremRIN1A0eGRKcjh0QVVpVzY0VTRjYnIyNUJpT2VGWHk5ZFNHakxZWmEz?=
 =?utf-8?B?d09JN0VQU09wempEQnNwUVIrZVU5NGJpc1Jva2hOOHZDdllYSlZtcG5TUXVj?=
 =?utf-8?B?VXdhZ0Eyc1hjK3JnTCtsdTBHZDJ4cHp4YUhOWURYcUwxV25hdVVqdWl5Mm12?=
 =?utf-8?B?R0MvMTdGTktmMnZ0WmlreFpVOFZiRlFScm15WHJ1WU1QSHFHZzhJc1NpdXZk?=
 =?utf-8?B?aHJUck1DYnFnZTYwNUxpcUpmdmoyc1hlYkR2emVRS25mQS80VjZTYmZwbzVj?=
 =?utf-8?Q?aoKOhxksy0eIS3rmS8yLxq4zOWMo0A=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCSPRMB0009.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RGJPUTY3Z2I1ZURmbVdxQUpZbENBR1VodUpsWWd1NTErQzRweVdrQXlCOXZm?=
 =?utf-8?B?M2dvanpyUnFZVndsOGJ0M2VQWTFLNkN0YzVmYXVQWDBpNDlnNk51MGNXeENY?=
 =?utf-8?B?Z3BWZFBhRklCcEtURWhObGdjeStybjl3NTgrcHZzYlc3ZjlHa0hPUENWZXBG?=
 =?utf-8?B?bTRHcE1kUmRMZlZ6KzlaVU9jc2xteUxZZnJVMmI2T0U4UTlzNzdicENGSmNk?=
 =?utf-8?B?NHVmVCt0UWI3MmhETU9wWjFaQzU4TVdmSFMzQThWVENodm9tWmFLLzRlWG5q?=
 =?utf-8?B?UG9sMEFiNWlIam92VWNESmw2UURoZ2IvRENsdUVxazZMUjl6dnVFTTFaRTM3?=
 =?utf-8?B?ckVHTkZMQ2JXQ1A2dHR2bjFPVGFGRjU1eitLQTAwU2phWUtmY09HZWVUNzVX?=
 =?utf-8?B?cW5aRlV5K1RmUUhtU0J3SnFFQkJKNGkzVlZtTFFDOGw5ZFUvK3lhek9ZQk5n?=
 =?utf-8?B?dmNQUmdJYWJzZkZGVzNMQVlySmRDc2tqT2dWcmNiNFBra21mVUpMVHVBK2VI?=
 =?utf-8?B?OXNJSXZrQW5paEZPc3JiNU55M0dLZGhhVkdqdDh6b3dhQk1UeTJzOGNlT1Bs?=
 =?utf-8?B?VE8zNXJXSzU3ajFtTm11NFFOYmNWTTBLTS9NMVhLOTUvMXJHRnlqYzhFNFRH?=
 =?utf-8?B?bDVFdVlmL1hqOVkrenZDSjhDOGtzT0hXa1hRWmFDbXU2MCtoTW1pQUpTMTEr?=
 =?utf-8?B?US9hQ2hoRjV3dVdxeUZXTEEzSVNLUVBjQzI4T2MxV21lNk9yT2lKUXNWSnJ5?=
 =?utf-8?B?WmtuemFqaHBtWC9FSUZiSTBpdnc1M2tnaGJnK0dGUFFsd2xhNTduK1lObkZ1?=
 =?utf-8?B?eEdyb2ZTTGp6cEd1eVdHYkoxVVZRMjJuK2FnQWx1djNEUXhFUnBjQmtrYzli?=
 =?utf-8?B?S2xYQ2VHYXViUEN6OFhFYjcwdE8vdXhyMk1URDFJZEQ2Z3M0cXk4b3JGQzFt?=
 =?utf-8?B?UjNaTzMxbU1UZDVJa2kyN1o4Uk1lem1FWDVteEVYRUFLdEg1RHNwQUlrK2VN?=
 =?utf-8?B?ZG40UElSTnNJdnoxNVEwU2pHdVd5dFVVYnV2eHVkWitrb1NQNGhGdXBXS3BK?=
 =?utf-8?B?QjNWRlB0cm1LMW9qdnpCTVA5N3o2NjBWckF3RnJaMlBJazRkenFlUWVnUTAz?=
 =?utf-8?B?S3NBaWwxQm1Rd2VZVjFrOTNmZ0JoVkttbHZhdzluSHRGZGhpUFhTcW1ZZGFB?=
 =?utf-8?B?M2xqRzFzdUt6VU9TYkUxRjJzQTVpcXFwb2pBTlo2eWE5SUVPY2xzRW1lbVpC?=
 =?utf-8?B?cTVEcTZNZEdkMEdTYkVXdVBYQTNKQ0wwbWJlQnRLNXd5MHN6T1hXVDlvd3dC?=
 =?utf-8?B?K2NJV3hyM3VGVDFUTHNjd0hCUndGTXZwOGY4b2lqcmVJVUJqS0gyRFlodFNz?=
 =?utf-8?B?R0dVNm1NVUN3Zk5nY3hrQWJObWkwR2xwRS9wUG5NWktlUU9TWmEyZUUvOExH?=
 =?utf-8?B?YVNwTVRoZTdVaENWbFVES0VMSlhQc1IyaW1LaXdJT2ZMMWRDY1o3Rng2eCtU?=
 =?utf-8?B?U3ovbGhJYjlJckwyQmxmR1NTTGtvOXpkNTlUb0lmS1VKRFZKWkVIczBMTmRU?=
 =?utf-8?B?aFpPVytyZWY3R3MySHBpVVIwdVgxYTFCazB2a2RHSElMNVRFbjVISDEzQmtP?=
 =?utf-8?B?NDBnUmNHUHhLK2lEN1kvZE4zS204SUpkc2NrTzhYa1I0Zk1ZTWxyMkZGUG5Y?=
 =?utf-8?B?T2VDUUsvSzJtNGtFWVR2QWpTcldNM0sxemY4MmJEM2Z4VmZjdG5XZzlIQnNB?=
 =?utf-8?B?QjJ4S2ZTbzd6eVBrbUZQbHQzRmFzZytJV2lQRHE1U1R4QlNRN2FWV3V2Y0M3?=
 =?utf-8?B?VDV4Y0ozaURuZFhNbk9JZlhLenk1TGVNeFNoNHRsQWdPUGxjNTZhMUx5TUE3?=
 =?utf-8?B?bmVNN1NSQ0RCS3Nqb3FiWGwvN0V0RGxaOVdtbE5rTEdtSDluYjhQMVRBQWRw?=
 =?utf-8?B?Ky9YSVZ6YXhzbk9TWU1yZFlBYklDUytVZU9FREtMaHd5d1VKaXRtMFZRbmc1?=
 =?utf-8?B?eERaTWd1a1RlSUVIS1RyS240Snp2UlI2dTBpT1I0aEZxaXlVeWlaeTJHTnlU?=
 =?utf-8?B?bkhTaFNXTFhjcHQvbU1BejFkTTZpbEF5d1VmNTZ2U21jQXNyM2lZZlNiWDVW?=
 =?utf-8?B?dldqbHUyNzFycmU4b3lzTjBNWWNuVE01R2Vac3VreTFhQ09zLzZLTXNLekp5?=
 =?utf-8?B?UUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCSPRMB0009.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b9a9835-6499-45d1-52b1-08dd826a7b6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2025 13:26:40.4800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zK39QYCJyP+XmA032f2VPuuAt2JxGzjmMSPMOxbdcGRzPa2u2c2pDaSLa9D/PfgMXLJQFafMomvdK+/s/JShxdafWKIznIWHNxAoIyub9gM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13573

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgeW91ciBmZWVkYmFjayENCg0KPiBGcm9tOiBHZWVydCBV
eXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02OGsub3JnPg0KPiBTZW50OiAyMyBBcHJpbCAyMDI1
IDEyOjM3DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjYgMi82XSBkdC1iaW5kaW5nczogZG1hOiBy
ei1kbWFjOiBEb2N1bWVudCBSWi9WMkgoUCkgZmFtaWx5IG9mIFNvQ3MNCj4gDQo+IEhpIEZhYnJp
emlvLA0KPiANCj4gT24gVHVlLCAyMiBBcHIgMjAyNSBhdCAxOTo0MCwgRmFicml6aW8gQ2FzdHJv
DQo+IDxmYWJyaXppby5jYXN0cm8uanpAcmVuZXNhcy5jb20+IHdyb3RlOg0KPiA+IERvY3VtZW50
IHRoZSBSZW5lc2FzIFJaL1YySChQKSBmYW1pbHkgb2YgU29DcyBETUFDIGJsb2NrLg0KPiA+IFRo
ZSBSZW5lc2FzIFJaL1YySChQKSBETUFDIGlzIHZlcnkgc2ltaWxhciB0byB0aGUgb25lIGZvdW5k
IG9uIHRoZQ0KPiA+IFJlbmVzYXMgUlovRzJMIGZhbWlseSBvZiBTb0NzLCBidXQgdGhlcmUgYXJl
IHNvbWUgZGlmZmVyZW5jZXM6DQo+ID4gKiBJdCBvbmx5IHVzZXMgb25lIHJlZ2lzdGVyIGFyZWEN
Cj4gPiAqIEl0IG9ubHkgdXNlcyBvbmUgY2xvY2sNCj4gPiAqIEl0IG9ubHkgdXNlcyBvbmUgcmVz
ZXQNCj4gPiAqIEluc3RlYWQgb2YgdXNpbmcgTUlEL0lSRCBpdCB1c2VzIFJFUSBObw0KPiA+ICog
SXQgaXMgY29ubmVjdGVkIHRvIHRoZSBJbnRlcnJ1cHQgQ29udHJvbCBVbml0IChJQ1UpDQo+ID4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBGYWJyaXppbyBDYXN0cm8gPGZhYnJpemlvLmNhc3Ryby5qekBy
ZW5lc2FzLmNvbT4NCj4gPiBBY2tlZC1ieTogQ29ub3IgRG9vbGV5IDxjb25vci5kb29sZXlAbWlj
cm9jaGlwLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogTGFkIFByYWJoYWthciA8cHJhYmhha2FyLm1h
aGFkZXYtbGFkLnJqQGJwLnJlbmVzYXMuY29tPg0KPiA+IC0tLQ0KPiA+IHY1LT52NjoNCj4gPiAq
IFJld29ya2VkIHRoZSBkZXNjcmlwdGlvbiBvZiBgI2RtYS1jZWxsc2AuDQo+ID4gKiBSZXdvcmtl
ZCBgcmVuZXNhcyxpY3VgIHJlbGF0ZWQgZGVzY3JpcHRpb25zLg0KPiA+ICogQWRkZWQgYHJlZzpg
LT5gbWluSXRlbXM6IDJgIGZvciBgcmVuZXNhcyxyN3M3MjEwMC1kbWFjYC4NCj4gPiAqIFNpbmNl
IHRoZSBzdHJ1Y3R1cmUgb2YgdGhlIGRvY3VtZW50IHJlbWFpbnMgdGhlIHNhbWUsIEkgaGF2ZSBr
ZXB0DQo+ID4gICB0aGUgdGFncyBJIGhhdmUgcmVjZWl2ZWQuIFBsZWFzZSBsZXQgbWUga25vdyBp
ZiB0aGF0J3Mgbm90IG9rYXkuDQo+IA0KPiBUaGFua3MgZm9yIHRoZSB1cGRhdGUhDQo+IA0KPiBS
ZXZpZXdlZC1ieTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydCtyZW5lc2FzQGdsaWRlci5iZT4N
Cj4gDQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2RtYS9yZW5l
c2FzLHJ6LWRtYWMueWFtbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9kbWEvcmVuZXNhcyxyei1kbWFjLnlhbWwNCj4gPiBAQCAtODAsMTIgKzg1LDI2IEBAIHBy
b3BlcnRpZXM6DQo+ID4gICAgICBpdGVtczoNCj4gPiAgICAgICAgLSBkZXNjcmlwdGlvbjogUmVz
ZXQgZm9yIERNQSBBUkVTRVROIHJlc2V0IHRlcm1pbmFsDQo+ID4gICAgICAgIC0gZGVzY3JpcHRp
b246IFJlc2V0IGZvciBETUEgUlNUX0FTWU5DIHJlc2V0IHRlcm1pbmFsDQo+ID4gKyAgICBtaW5J
dGVtczogMQ0KPiA+DQo+ID4gICAgcmVzZXQtbmFtZXM6DQo+ID4gICAgICBpdGVtczoNCj4gPiAg
ICAgICAgLSBjb25zdDogYXJzdA0KPiA+ICAgICAgICAtIGNvbnN0OiByc3RfYXN5bmMNCj4gPg0K
PiA+ICsgIHJlbmVzYXMsaWN1Og0KPiA+ICsgICAgZGVzY3JpcHRpb246DQo+ID4gKyAgICAgIEl0
IG11c3QgY29udGFpbiB0aGUgcGhhbmRsZSB0byB0aGUgSUNVLCBhbmQgdGhlIGluZGV4IG9mIHRo
ZSBETUFDIGFzIHNlZW4NCj4gPiArICAgICAgZnJvbSB0aGUgSUNVIChlLmcuIHBhcmFtZXRlciBr
IGZyb20gcmVnaXN0ZXIgSUNVX0RNa1NFTHkpLg0KPiANCj4gRG9lc24ndCByZWFsbHkgaHVydCwg
YnV0IHRoaXMgZGVzY3JpcHRpb24gaXMgaWRlbnRpY2FsIHRvIHRoZSBmb3JtYWwNCj4gZGVzY3Jp
cHRpb24gb2YgdGhlIGl0ZW1zIGJlbG93Lg0KDQpPa2F5LCBJJ2xsIGRyb3AgdGhpcyBkZXNjcmlw
dGlvbiwgYW5kIEknbGwga2VlcCB0aGUgZGVzY3JpcHRpb24gZm9yIHRoZSBpdGVtIGJlbG93Lg0K
DQo+IA0KPiA+ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvcGhh
bmRsZS1hcnJheQ0KPiA+ICsgICAgaXRlbXM6DQo+ID4gKyAgICAgIC0gaXRlbXM6DQo+ID4gKyAg
ICAgICAgICAtIGRlc2NyaXB0aW9uOiBwaGFuZGxlIHRvIHRoZSBJQ1Ugbm9kZS4NCj4gDQo+IFBo
YW5kbGUNCg0KQW5kIEknbGwgYW1lbmQgYWNjb3JkaW5nbHkuDQoNCkknbGwgc2VuZCBhIG5ldyB2
ZXJzaW9uIHNob3J0bHkuDQoNClRoYW5rcyENCg0KQ2hlZXJzLA0KRmFiDQoNCj4gDQo+ID4gKyAg
ICAgICAgICAtIGRlc2NyaXB0aW9uOg0KPiA+ICsgICAgICAgICAgICAgIFRoZSBudW1iZXIgb2Yg
dGhlIERNQUMgYXMgc2VlbiBmcm9tIHRoZSBJQ1UsIGkuZS4gcGFyYW1ldGVyIGsgZnJvbQ0KPiA+
ICsgICAgICAgICAgICAgIHJlZ2lzdGVyIElDVV9ETWtTRUx5LiBUaGlzIG1heSBkaWZmZXIgZnJv
bSB0aGUgYWN0dWFsIERNQUMgaW5zdGFuY2UNCj4gPiArICAgICAgICAgICAgICBudW1iZXIuDQo+
ID4gKw0KPiA+ICByZXF1aXJlZDoNCj4gPiAgICAtIGNvbXBhdGlibGUNCj4gPiAgICAtIHJlZw0K
PiANCj4gR3J7b2V0amUsZWV0aW5nfXMsDQo+IA0KPiAgICAgICAgICAgICAgICAgICAgICAgICBH
ZWVydA0KPiANCj4gLS0NCj4gR2VlcnQgVXl0dGVyaG9ldmVuIC0tIFRoZXJlJ3MgbG90cyBvZiBM
aW51eCBiZXlvbmQgaWEzMiAtLSBnZWVydEBsaW51eC1tNjhrLm9yZw0KPiANCj4gSW4gcGVyc29u
YWwgY29udmVyc2F0aW9ucyB3aXRoIHRlY2huaWNhbCBwZW9wbGUsIEkgY2FsbCBteXNlbGYgYSBo
YWNrZXIuIEJ1dA0KPiB3aGVuIEknbSB0YWxraW5nIHRvIGpvdXJuYWxpc3RzIEkganVzdCBzYXkg
InByb2dyYW1tZXIiIG9yIHNvbWV0aGluZyBsaWtlIHRoYXQuDQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgLS0gTGludXMgVG9ydmFsZHMNCg==

