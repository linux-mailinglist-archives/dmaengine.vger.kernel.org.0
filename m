Return-Path: <dmaengine+bounces-4315-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3A3A29ED4
	for <lists+dmaengine@lfdr.de>; Thu,  6 Feb 2025 03:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED749166936
	for <lists+dmaengine@lfdr.de>; Thu,  6 Feb 2025 02:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CB9126C13;
	Thu,  6 Feb 2025 02:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="DCfdsk0E"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0975F13AD18;
	Thu,  6 Feb 2025 02:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738809294; cv=fail; b=T6/J40sVTVISGiTyzdq7ty3mJqPdMMQMGvx/Q/Y32GTDj5hwlYAuurPUv2MvxUYAWm9C8TDStjHnnfoUWy3d8uVRjGwb3WLT327OuUkQ1JtOKUee3GgwHt91T/lJidm7WPfcLLX+jXqRDj36wPpn74hS8eOFaS08RuV3l3IlcBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738809294; c=relaxed/simple;
	bh=3IWygZkKhCcZuM43jzXATvU/8HsYtfJ7tVlMqWNK2wU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H03PN9EYirhKCPp4B+/ck3dHU8/uN4AJM+aCn7G7XN+eM+L1Ov1kTZCieDGbOCt0P22ichITbxFtDdeT34Ub/oUPMD9Xv2P62HKbB5gaxcJSpaeuChIQbgpgpoh/Lss7T6iw04xVcPPTCvj8QpueytNdyilOS84szCxu5cJTtd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=DCfdsk0E; arc=fail smtp.client-ip=40.107.94.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MNPpJHPGCSbbEkOjCa46pmk6j1VCwvlnvX4id8JnRp8exh8r+9xsr43KGxSKpJggsjnZmDDlv2ave2e5qRxk6Tqb1UIPK8an9PLKqsDMPd8XFPXXHBGZkKjxJxCsBqgxJG5Oq4IuyeSMHHLgxo8QLIm1G2j1K89Lr4KIQuiW+d0YIOHbYXPCFzXWrvm89Sp+E6AqdlvEGCuz0UCnOhq8MhXgDNmfd1FkXEz2GGihZ32pKpUFtfXH/qk8jAATiCXjW+EFNnrk4zMxBlcoXMr3GUEIg8bNlAp/HwgxUpdIV9KYxbdecDDEOolwM0fuzGkn0Fs+hwZI/M3WbtFWfSBamw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3IWygZkKhCcZuM43jzXATvU/8HsYtfJ7tVlMqWNK2wU=;
 b=xBcDgM6Of6f6S99yn3I2WeqHZKaRSG1sSeb1rYk4228/M97tNK3V8p/rfxnE8YszgvYLC3S5wjdT0LYC1JGdcA6GT8uYyz/CAbD3ipudWWi2KyLmD83dHhskMuWj0BoVKpjDsXYVOGZAuvGGjF/2loattxdui8dSZJCb0lLT6gqT5FT2wSSDXbwzvA82+wA92QU0I1IcGw3I/CluDIcXQdoQN9jOlbNwTBe+RcxxtQdHCbIrowNTYL3ICbPqoF08N25a628pqZdyWF4rvnqFakSe+m5pIMRgn8eHMW3lu7RgLFhoa2myGlfrH20zdc39O2558/OUny5yObdnajpfFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IWygZkKhCcZuM43jzXATvU/8HsYtfJ7tVlMqWNK2wU=;
 b=DCfdsk0EEj5luimj9CXZDtwsBQJjumLiRcF020dHzpsgbnsR/SjiqwVtVPnsD4DzMFdNpNG0X0fSWk+C1aRey/1ETp621cp6zab3V16b/8czGhJThVZdyleEE2kcoquYG6dAVWZ9NrB8nEtxDDAEqMKkdeijeeKT8OciJBJnsH3NlfeAHkvgDsw7wt//r9ePcXBHxZvqJTqXixIm8ZFMnzxS1mYkFhVxyESjMOcTFxm4KshuL3zWXtE5ZLNolbjwkcv3G1NGc2NRx4nXWVcYlEx3cz3RbpLcW39S4u71Hr0NtdlN3vUf+DzL5OG2V/hMvpIStUedLSqxqwagg5aOsA==
Received: from PH7PR11MB6451.namprd11.prod.outlook.com (2603:10b6:510:1f4::16)
 by MN0PR11MB6205.namprd11.prod.outlook.com (2603:10b6:208:3c7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Thu, 6 Feb
 2025 02:34:50 +0000
Received: from PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8]) by PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8%6]) with mapi id 15.20.8422.009; Thu, 6 Feb 2025
 02:34:50 +0000
From: <Dharma.B@microchip.com>
To: <krzk@kernel.org>
CC: <Ludovic.Desroches@microchip.com>, <vkoul@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <Nicolas.Ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<Charan.Pedumuru@microchip.com>, <linux-arm-kernel@lists.infradead.org>,
	<dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <Tony.Han@microchip.com>,
	<Cristian.Birsan@microchip.com>
Subject: Re: [PATCH 2/2] dt-bindings: dma: at_xdmac: document dma-channels
 property
Thread-Topic: [PATCH 2/2] dt-bindings: dma: at_xdmac: document dma-channels
 property
Thread-Index: AQHbd5FxpxZOPWR/L0mgfGnIIneVmbM4llGAgAAmnACAAAUfAIAAzjOA
Date: Thu, 6 Feb 2025 02:34:50 +0000
Message-ID: <2158268e-7b85-42aa-98ff-193f9a7ef5b3@microchip.com>
References: <20250205-mchp-dma-v1-0-124b639d5afe@microchip.com>
 <20250205-mchp-dma-v1-2-124b639d5afe@microchip.com>
 <20250205-dynamic-scorpion-of-climate-9e7b7b@krzk-bin>
 <74ac11e8-2285-436b-9186-4793cb2b7239@microchip.com>
 <870df4b8-fa96-47c1-b82a-5db52a5f0788@kernel.org>
In-Reply-To: <870df4b8-fa96-47c1-b82a-5db52a5f0788@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6451:EE_|MN0PR11MB6205:EE_
x-ms-office365-filtering-correlation-id: 37f965c7-db80-42e8-4365-08dd4656d499
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6451.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eHJ2Z3FEMkdNekFROUU4VTE3Q2E5R0d3dWZ2SE1xUnhUM0VWVjVRNytnM3FC?=
 =?utf-8?B?alBnOTZJQ3hvN1VkMm9sSnV0akk5N0NBNksyTGFOZUl5c0lyUXRjVUR0bzJT?=
 =?utf-8?B?ODUvUCtVNVpiNjc5c0ZYeVJsOFVaMXJLTkhWTUQ0ZVNGOFpjUC93dXkyeEVv?=
 =?utf-8?B?YVRvZFBESGNFQ1JuVWRnZzB6QjRNY2JnVDdULytnWm8vazBvOVZtNTdYMWZq?=
 =?utf-8?B?MCtYYWNlaURIUHNHWnBiRUVHbHhqYzI4QUdWU3h2NU1lUmxlZUN1NHpFNDJz?=
 =?utf-8?B?Mk9LN1V5ZzcxbXIzWDhNOEw3WC8wVlIvd0N5NjhCSzFVdkwxUlljdkFhZm1O?=
 =?utf-8?B?T2lIRnRYdFJkN1JDaWh0dVBuV3JtdEZGV1E4NTRtQXdlZ09paGhHVXl5YW9I?=
 =?utf-8?B?aitoVXM0cE1lNkpYLzVqYmNML1RmQ08xOXhuNnFWTGYyZUJUR2tzK01RKytE?=
 =?utf-8?B?RW5LenhHUWlYaCtTUmM4Qm1RZGl6UXRtdkxzNmFsamlybnBvQlBRYVZ5ZnNj?=
 =?utf-8?B?eHlMWlVyRWFpVGNIWlRXa0NmbGgzSXo5d0ZzYzFFL1J6QkZvdThJaEk4aVl1?=
 =?utf-8?B?L1RmMHBjL0NIZVpIOEc1YlFueWczSFVLMy9OMmo4UyttajIybHhjUXhSUjEr?=
 =?utf-8?B?WDNLbGFoSWFLOVVwQmhySVJaTDJPQlNrR0tpTmV3Nm1mN3l4R1BQbWRGWjJ4?=
 =?utf-8?B?L3BWdmlTd01aN0pRaUJodUY1WmZ4SEVWTmorZkZiUzZWYXkrM29wSS9qc1cz?=
 =?utf-8?B?QzM4ZWUxeldYUVVQS1dYeHhQZWVSUlM2VUk4TnZOcEs1dk03VXZBWk9nUUNy?=
 =?utf-8?B?L2h6TjhveTNieWp0aDNnclpUdGNFaUhwSEM3eUIwZnFoU0tRVTJNVEo2SEQv?=
 =?utf-8?B?RG5NbCtXUElnYmt6bkNJRnFLcmp5cXc0MHg5RTE1QmtMN2swaXFEQ3JrZXQ2?=
 =?utf-8?B?M2NrenJBUVY3NHF0UmxhczJscUQ2TllDU2lTZW9hVFFRc2V6a0lUWXhHcVd2?=
 =?utf-8?B?NTBoNUxUM2NkbVA0T3RQdVNUYmhKRXFwOW50eGFMRFZ5SHRVZW5mM3kzOTlR?=
 =?utf-8?B?bGEzU2JMWGFTT3JsTGQzY0c3cWR4cGxJc09nWTNvZkJ5ZTdTd205QXQwZXBI?=
 =?utf-8?B?RDBpY1l4bU5WTVgyMkJXZjIzUnBwdGdldVlkQUJKM2dmVXY0Q2E2bk5GSVNn?=
 =?utf-8?B?MzluSWlUR0NUUFZxbXFRTnRSd1dzQVNYSGlhWStDVExmYVFKeXFaWGFObWdx?=
 =?utf-8?B?d3FHbWVOZGFjeDVUTDhoak9hV3ZpQWlMc1A3cGliaVFJU0hhWm1GOHlLU0ds?=
 =?utf-8?B?enF4ZExlYUlxTFZ4cGxJQTI3SXdJUkVrMGJkNkJtSmk3RkpiMDlLOURYQy9x?=
 =?utf-8?B?Nm5vZ3JqQ2JvbkQwd3ZrVkJGMHNjdmFEc2h4bzllS1NMRWNlbE13a3JYaEF1?=
 =?utf-8?B?RXE4aWVWTi9WR0NJcUF4OXNyZDRXVzZFWFNYQk55SWdUVVF5bExNdERwUnhh?=
 =?utf-8?B?SUh2VWtqaTd1empuRDBUN2hqZkdEVkpNN3ZvenJPVkkxWFB1Q2wySWU3YlFl?=
 =?utf-8?B?OHJJekp5NjNSZ0p5ZTdpTk0zTmdtOGtZREZBZ1lndVV4NWgxVU5iYkVRejdH?=
 =?utf-8?B?SUQwQmJrR1VmaS9zajI5Zy9kbjZjYnhGL0VNK3c5T0dZN21qRjlkaDNHTmtB?=
 =?utf-8?B?MXNWMzdrUVFWOWRlcVZtOUxNbWRNVVdnZ21NTnBaTEUybVQwcmxnV0FtRVNG?=
 =?utf-8?B?R2FQQWdpaU9lRHZ5TndYS1pNOXN1RWFVcUxPUXdtaTJ6UWR2Nzh1MjAwRmtX?=
 =?utf-8?B?dXpPbTNUditYZEV1YWs4ZXpRR2YycUhERmJFQ0dYc3Z2cGExM1daU3YvK21r?=
 =?utf-8?B?Z3kwY0s0dy91cEVJQkxIV1lwTk4xTEdVOVJBWUxwSkttSDVsWHdzT1N3U1ZE?=
 =?utf-8?Q?9Hqv8OGOhzRVZ4vWNmFaZUhqEpDLOug4?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eEhOUXZvZEVEb3VpTFhFSTYvVTNEYTVzRDRLNWduaGxWWEE2OUxIWmxrQTl5?=
 =?utf-8?B?czZpUTNDYmswd0V5b0RiUVNTNXBQMlg5OTh4T0RDOERES0dPYzFNYTZmVUY3?=
 =?utf-8?B?MldLRExYa2YxbXkycjFXQ29zWUJkUUdOQ1BCbFhmeTBpUW10MWdOSktydHYx?=
 =?utf-8?B?QWlKdUUrV0RRVWlXYU1DaDRiTUtuWlZuVkprU2hubno2VWc3U2FFeldmVGpa?=
 =?utf-8?B?dkxQd1piTHFqNmExWTIrcnRrTVppNDBDRUZyN0FKQWpsajRHMGNHdGlMWlds?=
 =?utf-8?B?cVM0TTJ1RndXSHpmU0R5YjdGb01hZ3VIT1kwNXludFZvRGRqcFlzZ3diOStn?=
 =?utf-8?B?a1hwMWFzYlBnK0cySkFjNnNhanBsaVk3SXVXVjhnQWhiWS9ZcGMvbjlXU0ZC?=
 =?utf-8?B?RURzV0VTcGV3eURzV3JpblVqU3daQWxvcWdma2NpdU90UGFtZStBN1psZS9v?=
 =?utf-8?B?cmVJZ1ZmTW9ITFdFQ05ubTlYaXRtWWFxRTlScGl0RUx4VzEvMHdnV0huSEZR?=
 =?utf-8?B?RXRDaFFVcmVuL3hFdzJOYTRJZ0VNSWdmbi9sOWFBTzlqVWlrLzF1TjhEWE00?=
 =?utf-8?B?R0lDZXA3TFFsR0FMWFlrYkREUnR3MWVLUm02MjZLaTUrSVZXM093cFh2eDE5?=
 =?utf-8?B?aHJsME8xL0ExZzlMMnA4bHczamMvWEdKYjlITVk1aWs4d3BPMXFmOTg4a3Nx?=
 =?utf-8?B?YjY4c3dhWmhlZzhYeVQxMERKYXpqaE5UR2Fwa1d6SEFrYmNjbU5ZdUtoTElV?=
 =?utf-8?B?UGJFMDFmWTRuTFFydW05djJQVEY2UDNJYmZvT2ZWL1NiWFl0M0xzOW1pTVVG?=
 =?utf-8?B?NXhHOU1mSTZsVDZWQVAwZWE0M0lUd216RDQvSUMyQnN2T1FZbkpFbW11NU1o?=
 =?utf-8?B?Q2xTaWxmSkJkZmFrdXg0L0d4bTAxemFPMDQwTnYrV3RNOFZBakhYb0RuWVY0?=
 =?utf-8?B?MXlyVHowdE5RaTRMRHEzL2xDWHBqYTY5MlZtem96Z2VKV2FMS1FZWXNpRW5z?=
 =?utf-8?B?MlhBOWMwN3lmd2UxNWJDVHY3bDFIQTRRMlRvQVdUTVhIYjZPcUxQUCtUU2JD?=
 =?utf-8?B?dkh3R2d3U24ySmlrcGp3OEcxRTk4TWRMY0lwa0IrQjdvdkZkTjVMM0o5SC9x?=
 =?utf-8?B?bS9IRldUZkRYc0FSU1d2cFFBSnJHdHNGdytkZElZeHpYWnlmbTlDbE5ua0Fl?=
 =?utf-8?B?QzVvUDlzT2RYdmR1ZzFZUDF0Q1FHUXdyVDJJVllTSXpQek5ROGFKbEJIV0hq?=
 =?utf-8?B?Rm5wTWFTZ3ZwVGloUTZsQUtPZnJwbzZIZTgvRkdVbzk2MzJiNjJoTW5Hd3FL?=
 =?utf-8?B?R3c2UzE0dm01amNyYWF3UFNOMjdmcWFkVE00NWdXZXhuYWZwOEc1bW1ZMlR2?=
 =?utf-8?B?MDhUMTJhR3kwbm9vbUJyK0VKSUM1QkhQbmxDbC9jbGYzeFFMZVo1bHB3WURr?=
 =?utf-8?B?M1BLZDZwM2VvNksrTXVGazFHeUk4L3dDNy9UTEgwYTByL0tPNVlIVkZiaFR2?=
 =?utf-8?B?Qi84STQva1VCbVNrYUVLKzFzRW5heVpXdUR4OXFtc1lCa3dodUFGSlNCZXdy?=
 =?utf-8?B?T3FNNnJVY1Q2cHdQU2R2V09KZTRtRk9WcXAyZmVaRFFPU3JsQmlmOGdmYVRE?=
 =?utf-8?B?UklFYzNCcDlpZG1obUJkMW1tcUhtOFN4Z2cwZFpRbVUyRk9rc2pFWVBmYlUz?=
 =?utf-8?B?bmRPVEJ1NHlvVjNUM0Z6MEgvSk5iKzFEQ0N1d2tscEtkWDJicDlScFA5SnpE?=
 =?utf-8?B?Q0dPQms1NmR6SllhazFPc1J6Q0xnZE5OemM2Sll2cjdudGhJUUdmSXhTVXcx?=
 =?utf-8?B?blZSS3dBdFN4VmJaNno4dnpac3VUMGpaTktOa2JHQVFjSFRnZ1FuOXVWeSs1?=
 =?utf-8?B?UTRpWlQwaTBkSncybG1FVTVrNUlQd2VmWFM3ZUphb2pFbVhWKzJYRFVNNlVV?=
 =?utf-8?B?cTFhWUtOWUIzVDY2ci93OHppWkpGZW1kU3BuZnZRNFhtNWhzTWpuOFF0TU5r?=
 =?utf-8?B?eXpUUmtDTkJLVUZRQk1KUU9qMHpqWXVvZDh0U1VRMmhMalh4TlVpWlJWRzlK?=
 =?utf-8?B?VUw3bFp1TGZybEhIZkJXbXFWbmlrRlJUVVJzZzdzVGJ2QlBteDl4MitSZTE3?=
 =?utf-8?Q?Bnnxu13F7tHafp0hrgpHNmxqW?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <475CD05DA352304AB29EB9CFB843BE4C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6451.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37f965c7-db80-42e8-4365-08dd4656d499
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2025 02:34:50.3818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1wpXMYFYeYQNSfMvu+RX803NAtDRw1bL2llsTLT02AsGNCdPr+jdIaIzVFo6iP3e/WJu7YmmQq6jZinSTbC25w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6205

SGkgS3J6eXN6dG9mLA0KDQpPbiAwNS8wMi8yNSA3OjQ2IHBtLCBLcnp5c3p0b2YgS296bG93c2tp
IHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0
YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDA1
LzAyLzIwMjUgMTQ6NTgsIERoYXJtYS5CQG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+PiBIaSBLcnp5
c3p0b2YsDQo+Pg0KPj4gT24gMDUvMDIvMjUgNToxMCBwbSwgS3J6eXN6dG9mIEtvemxvd3NraSB3
cm90ZToNCj4+PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0
YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4+Pg0KPj4+IE9u
IFdlZCwgRmViIDA1LCAyMDI1IGF0IDExOjE3OjAzQU0gKzA1MzAsIERoYXJtYSBCYWxhc3ViaXJh
bWFuaSB3cm90ZToNCj4+Pj4gQWRkIGRvY3VtZW50IGZvciB0aGUgcHJvcGVydHkgImRtYS1jaGFu
bmVscyIgZm9yIFhETUEgY29udHJvbGxlci4NCj4+Pg0KPj4+IEkgZG9uJ3QgdW5kZXJzdGFuZCB3
aHkuIFlvdSBhcmUgZHVwbGljYXRpbmcgZG1hIHNjaGVtYS4NCj4gDQo+IEhlcmUtLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLV5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eDQoNClRoYW5rcyBm
b3IgcG9pbnRpbmcgaXQgb3V0Lg0KDQo+IA0KPj4+DQo+Pj4gVGhlIHNhbWUgYXMgd2l0aCBvdGhl
ciBwYXRjaCAtIHlvdXIgY29tbWl0IG1zZyBpcyByZWR1bmRhbnQuIFlvdSBzYXkNCj4+PiB3aGF0
IHdlIHNlZSB0aGUgZGlmZiBidXQgeW91IG5ldmVyIGV4cGxhaW4gd2h5IHlvdSBhcmUgZG9pbmcg
dGhlc2UNCj4+PiBjaGFuZ2VzLiBBbmQgaW4gYm90aCBjYXNlcyB0aGlzIGlzIHJlYWxseSBub24t
b2J2aW91cy4NCj4+Pg0KPj4+IEFwcGx5IHRoaXMgZmVlZGJhY2sgdG8gYWxsIGZ1dHVyZSBjb250
cmlidXRpb25zIC0gc2F5IHdoeSB5b3UgYXJlIGRvaW5nDQo+Pj4gY2hhbmdlcyBpbnN0ZWFkIG9m
IHJlcGVhdGluZyB3aGF0IHN1YmplY3QgYW5kIGRpZmYgYXJlIGFscmVhZHkgc2F5aW5nLg0KPj4N
Cj4+IFRoYW5rcyBmb3IgeW91ciBmZWVkYmFjaywgZG8geW91IHdhbnQgbWUgdG8gaW5jbHVkZSB0
aGUgZGVzY3JpcHRpb24gb2YNCj4+IGRtYS1jaGFubmVscyBmcm9tIHRoZSBkaWZmIGluIHRoZSBj
b21taXQgbWVzc2FnZT8NCj4+DQo+PiBUaGUgcmVhc29uIGZvciB0aGlzIGNoYW5nZSBpczoNCj4+
ICJUaGlzIHByb3BlcnR5IGlzIHJlcXVpcmVkIHdoZW4gdGhlIGNoYW5uZWwgY291bnQgY2Fubm90
IGJlIHJlYWQgZnJvbQ0KPj4gdGhlIFhETUFDX0dUWVBFIHJlZ2lzdGVyICh3aGljaCBvY2N1cnMg
d2hlbiBhY2Nlc3NpbmcgZnJvbSB0aGUNCj4+IG5vbi1zZWN1cmUgd29ybGQgb24gY2VydGFpbiBk
ZXZpY2VzKS4iDQo+Pg0KPj4gSXNuJ3QgdGhpcyBhbHJlYWR5IGNsZWFyIGZyb20gdGhlIGRlc2Ny
aXB0aW9uIGluIHRoZSBkaWZmPw0KPiANCj4gDQo+IE9LLCBzbyB0aGlzIGRlc2NyaWJlcyB3aHkg
eW91IG5lZWQgdGhpcy4gSXQgZG9lcyBub3Qgc29sdmUgd2h5IGRvIHlvdQ0KPiBuZWVkIHRoaXMg
cGF0Y2guIERvIHlvdSBzZWUgYW55IHdhcm5pbmdzPw0KDQpObywgSSBkb27igJl0IHNlZSBhbnkg
d2FybmluZ3MgYmVjYXVzZSB0aGlzIHByb3BlcnR5IGlzIGFscmVhZHkgZGVmaW5lZCBpbiANCmBk
bWEtY29tbW9uLnlhbWxgLCB3aGljaCB0aGlzIGJpbmRpbmcgcmVmZXJlbmNlcy4gWW914oCZcmUg
cmlnaHTigJRJ4oCZbSANCnVubmVjZXNzYXJpbHkgZHVwbGljYXRpbmcgdGhlIERNQSBzY2hlbWEu
IFBsZWFzZSBkcm9wIHRoaXMgcGF0Y2guIA0KQXBvbG9naWVzIGZvciB0aGUgaW5jb252ZW5pZW5j
ZS4NCg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4gDQoNCg0KLS0gDQpXaXRo
IEJlc3QgUmVnYXJkcywNCkRoYXJtYSBCLg0K

