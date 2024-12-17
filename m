Return-Path: <dmaengine+bounces-4006-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5AE9F4DAB
	for <lists+dmaengine@lfdr.de>; Tue, 17 Dec 2024 15:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E1ED16F340
	for <lists+dmaengine@lfdr.de>; Tue, 17 Dec 2024 14:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2091F471D;
	Tue, 17 Dec 2024 14:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="U1R0oTKr"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2067.outbound.protection.outlook.com [40.107.22.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D397762F7;
	Tue, 17 Dec 2024 14:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734445593; cv=fail; b=KZac50HgmbA9qm59tguoybu2IHsk2ekzHbY91dg/GVHq2iU4WnhL5U39K1x2NShumGzybHfyXJ+dgUNk1bdTzWIRoE6kMYmlt4RMt287PGIYQekpPv1mHKXMY/Q7e2g3+Vccdoe907gZ1eX68IlA3QtlO8LjuFPvKuzzRUTtKZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734445593; c=relaxed/simple;
	bh=kPL4J2Lju3yWUeFlIdvMfmvA2AlokmxBbQrQJ14csaw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UeFpaI5K7QY56weKLmq38UTzGRqJDUhptUTzIXc/PkBP7FiZStda6nN630erQHC1uV01SqQotnI7uEI04TAxnhbbwLzDyjud6endLdX36SwzJy06cGFTuBhbzCo8rdYBIqhxwB61RgikUmS1e6KPinxmcHOH3N418x2fyaSgxSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=U1R0oTKr; arc=fail smtp.client-ip=40.107.22.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VYTpPJT8ecX6J7NglkJ/5fC5aPl5rHTsys2vmO2tKW9SjBUhGccKCXjKuxkimZV6GwIfsvdk2h4PYCnp9/xS6qJtKrJaguXjkKC0piVwIpx1JHfmE0ePyfQTZS/+vqyE04/ZxTzzdRjN2MaG0XwD93I4AgtFMhUJ19f3w8x0zn70SiMkvDdKT696Hk7oGQYCGTwTexXQQN1MGZy0PocRPKnP5Fz2oJX3rEXsvCNuCj49/s8muvZlGdNd7wqlbWnOB+ptbaqu1LytUXJI4AUKT3OzjB+n5cdm4an2Pn3qk5S5h7ZFLCO10C1kmmV0y8ml9NJDbZ6/qHvM416k8KrWhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fb1RP2zoi11ArkA/2rqXrXwlZIP1+Zbeq9yyLoV1lvg=;
 b=WtHjbnU8avwQ9F2Jt4ysi//7Rdb/8BYnIbUgTVLjH/Q4d2gLX3zHDlZQxMml2OGI2FmMlLHt2gHgIq3//6X54gbHvPGp33SJn/Yu9QptDKNg7rmtoWYqhEUf6DCrDawjcdbwUxMjZrv6m7SiLFOIEp+iUWUNA3GSzJVCD1amPL89BJNcOcRfOkq4WBnTGMrlxgn7lPyZgBFObxEmBOJYDqnQsIP5/rkiKuIPZSyQYm8ppMKiJj9LHlnsn9Ol8bEeubz8pFrktE3eh7UPICqNp45l7FWM6GRd6k+J8W3dJHLyTJ/rBUMCFS6fR5qPyweRtQXxtJu2kNDewjMtWFI/9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fb1RP2zoi11ArkA/2rqXrXwlZIP1+Zbeq9yyLoV1lvg=;
 b=U1R0oTKr2NWfc2/Kk+djMeB1oksjSjlDufOPKu4oSDo/X7GqvCRpKCd9VWCP47pP8PyN7PYuIf2PyJPZtHKXjEjDXhaI+K25xQOK7vWlyjagArH4V5xR0qqFG4KgFffPLg9IKiklPQIIo6TGkHukF6HesYjHuerbR3bvTqbrpsUnpzQ4uIIfVV6AjrOf/4j8gY9UdGD/bw0zscxNWLcfFeaP/cun+lusR5onYMnRrmS+C7RCX/6AKW8ZfXgkMBybi3GKCb2MSyTVJ7XDFnnTdh5/uuaXy0Pa41atO2sV9LKnPiWUSgXriKjhx8PG21iqid2uVgHGXubUAyHXAh4+Pg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9550.eurprd04.prod.outlook.com (2603:10a6:20b:4f9::17)
 by DU4PR04MB10669.eurprd04.prod.outlook.com (2603:10a6:10:58e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Tue, 17 Dec
 2024 14:26:28 +0000
Received: from AS4PR04MB9550.eurprd04.prod.outlook.com
 ([fe80::e28d:10f8:289:baf7]) by AS4PR04MB9550.eurprd04.prod.outlook.com
 ([fe80::e28d:10f8:289:baf7%6]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 14:26:28 +0000
Message-ID: <15bb8eb3-9da6-4ee0-afa5-dab523d43005@oss.nxp.com>
Date: Tue, 17 Dec 2024 16:26:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] dt-bindings: dma: fsl-edma: add nxp,s32g2-edma
 compatible string
To: Krzysztof Kozlowski <krzk@kernel.org>, Frank.Li@nxp.com
Cc: dmaengine@vger.kernel.org, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org, s32@nxp.com,
 Christophe Lizzi <clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>,
 Enric Balletbo <eballetb@redhat.com>
References: <20241216075819.2066772-1-larisa.grigore@oss.nxp.com>
 <20241216075819.2066772-6-larisa.grigore@oss.nxp.com>
 <0b50fbb0-f32e-4c77-a277-bd64256ca2f7@kernel.org>
Content-Language: en-US
From: Larisa Ileana Grigore <larisa.grigore@oss.nxp.com>
In-Reply-To: <0b50fbb0-f32e-4c77-a277-bd64256ca2f7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0128.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::33) To AS4PR04MB9550.eurprd04.prod.outlook.com
 (2603:10a6:20b:4f9::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9550:EE_|DU4PR04MB10669:EE_
X-MS-Office365-Filtering-Correlation-Id: 668a6c91-b6cb-4e69-30fd-08dd1ea6cabd
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aC9lSGNNMS9INGxiY05Id1FlM20rclB1a3dHT3podm1ESU5rSkNBVUVIMGFN?=
 =?utf-8?B?Wnl1b3BxTWQrT3pqcHM4UzhQVzlOL0J4TXpHS3ExNDlaYVdIejJ6MDFybzlx?=
 =?utf-8?B?Y0pKejRlcngzZ3NBUVBjTGlTQW1oeTlDZUpGZ2wzVHFhOG41NHF6dTFMVmx1?=
 =?utf-8?B?bWN2NndpSXBiWng4NmxkSDBOdEFIMi91WXdkajYzc2dCTTlTU3NJNXpBcWhs?=
 =?utf-8?B?ZWFHOGZLOG1jU1YyalBKNkRnU3pkV2N0RzNLK1FBdzR0VXFGYUZRUFBoY1I0?=
 =?utf-8?B?T0ZrWUk3aExoQU5GTFJxN3RDMzB6NVdkalI5VmxZQnhIU1puS3ZJV01STnRE?=
 =?utf-8?B?T1FJS2tqb2liOW5yck9reVNoQW53MzlTUzBxN203Z1drU3k1VG1CM0tucThO?=
 =?utf-8?B?VHFGdWFqajFMNzVNTW84bWxza29DWXJWc0VSL2g1U29haVd5UmNPcXVuQ1hZ?=
 =?utf-8?B?WXVDa2lqdFFrMGwyS1crSWxWRlhQaVoxYUV2WUxHSVUzcGdhRWJ3Skdrc1hE?=
 =?utf-8?B?NTErUGFiSThzSmxYNDJPVTZFblorUkFrVGVYZGUxdG81NkhTc1lPR3QrMmpm?=
 =?utf-8?B?emMxdDFaODQ2bEo5Wk9JQS81OGYzc0JKNU9RazkzMDN5eVhWcEYvVS82bENi?=
 =?utf-8?B?WXZFdGoxRlR6cjVZVkE1ODZtbDdNODE4Y0JjbVNRNzd0cDZXZStiS2NvamRt?=
 =?utf-8?B?aG1id2RwaUxncm8wRzAvTW5lbUc1eGEvakI2QVc1NC90bmJscTFKdHBqWVMv?=
 =?utf-8?B?OW5rRW1vMGxPRklXaDdoQ0JlWGVrVGpkcjdDSXl2TnAyQnpqSCtnNkY4dXBV?=
 =?utf-8?B?Sis4MS9nRnc1d0dIb2hRQ2JJekZkL011cXZLSVIwdS92aW11bUxqT2VhbDJx?=
 =?utf-8?B?dFJiME5SL3VQdlZnZFl5eVJRYzg3YjVtZlk4Wm82YnEwOC9zZFZGampXOFhB?=
 =?utf-8?B?V2h2S25CZVVpZE5OdXdxa0VtdXRaN1lUN2VyWSs5TndiNHJCKzZkVktMd0lm?=
 =?utf-8?B?Y3NtWE95M1lPckdXNHk0WW9GYXNBU2dxK3dpUVF0aUxvaUI5V0NHV2RDMHJW?=
 =?utf-8?B?UGhJTk9CblBNbFBoSHJaczBQbk4wRDVMNWFZQUFRZkoxMVRKNEY1OU90Rk5a?=
 =?utf-8?B?QWdZaDNHSlo3NEJUVXRvNk1nbnl0S0VpcWlwLys0eFFCelNUMjhlSU9ObkUx?=
 =?utf-8?B?ZklEbGdIQ25wdTk1VCtDOE5ieHJiZHN4UlRnK3lCS0FWNjQwK1JDMTRjRTZu?=
 =?utf-8?B?dXplQWpQbVp0Y0N2eEN0Vng2VjFjS2drVUozcHJSVUZNQXpFZVpYUmpoSS9Y?=
 =?utf-8?B?MTY0Y29ISkFLdXZNbWVLQkNXa1FyS1BSWXo1ZXptbXJPMHdGb2VKVmp3VmM4?=
 =?utf-8?B?dkNYcTJqMzNoN1JLVWNTTmFFempHcXcrTm9qMTVvNC9CZno4QkJrM2hOeWli?=
 =?utf-8?B?N2ptbUY4Ui9EeU9UeHVwUmVGNUhGZGNjeEtrdWZJSmVvOU54SUFIY1J1UkJB?=
 =?utf-8?B?NmdMUGZFRU9PdkpLNFk1YXpVZkZzYVlHbVBsREc2U1RWS2kzTzBVcHRtMDli?=
 =?utf-8?B?ek5RcVRoNXhoYzRXTUlybWRoakVXcWxwYk9qSlhOZGY2NWUvT21sRGhGY1dB?=
 =?utf-8?B?VndVN1JRUjZZeVRqcjJKbU5JVGVlNXJMcEhyRC9qUjhBTnNDMmZuNlBGZEFh?=
 =?utf-8?B?dmU4S2VXZzNNWm8rNjZucXRidHlsNmxNaEtzNmZzMGVWWVFmNVBGRFEwT2FJ?=
 =?utf-8?B?anpoYTk2b0Jaakk4b2lPZWhPemJLVWxsaU81eVVJRnNlMVdncUV5MmdrRDY3?=
 =?utf-8?B?SFJOTDVvak01U0RBY1FNbW81bDdyWTFna1BqQk4vV1JwVHhkK1BadERLMGZO?=
 =?utf-8?Q?3wo+TTGHRH0MW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9550.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1RjRlhyaTh5V2UrUE1LU29MamEyUHVVa0JuVHdHb3hIckJ6dmtUdjlicDVX?=
 =?utf-8?B?WEV3WHBRanFOY3BEVmZIdXllUGtxZStTekJubTdCRzE2ak5nYmZDdmFaMVV5?=
 =?utf-8?B?YVM0c21yanBnUG5DSkkyODBlN2VFcFhBYnZDbitSZFA5dVFFTUNSQjAzT3BO?=
 =?utf-8?B?RithTTJDcUF3d2s0VVNhekxydTBWdXdnWmY4Q2Y3MHFRTXExc1h2eW55TzNR?=
 =?utf-8?B?Tms4b0JjQ1JLdGtNWW9KYmorU3NLOG1QbS9maXVzQ0grL24yUlI3enJXZFZH?=
 =?utf-8?B?NDZHd3d2SkhKNXdTd0cxY0pWMGw0UDQzcytsWGdnOUlRQldWVG1xRG81TWc5?=
 =?utf-8?B?blgxZ05ybVBqNDhqbGpHN2o3T2N3RGlOTEFVaHczZGJIN3ZwUzdNNktXNGp4?=
 =?utf-8?B?eExLa3A0OWJKLzZKT3MrNEVWMGgzSjhPWDMrcGMxN2JMeTMxL0NZZmlRdGtk?=
 =?utf-8?B?Nnd0UVhhTU9XOVJnaFVRcDREeGlTUVA4d3NvZkJhTzFlcDJ4bER3d3ZsVHBt?=
 =?utf-8?B?eGl5SFVaMGVHS293YXNHNXBkbGNpMVk0ZDJ5K25meUY1MUw3ME1Oc3MwQ0hF?=
 =?utf-8?B?YUlRMDNNRHlrTEl0YlRXS05vYWxNbjZaMUhTWFFyMmJRYkVScGRSWC92UGdY?=
 =?utf-8?B?NjFjMWwrZXpTQUNObUZTK3BKdFZJQnREUVl0RXdjMGxNUVFUQmRvdzNUUHZR?=
 =?utf-8?B?cWpyQ1F4dHRXeU9UQnljRUhPRG5Oa3FXaVlYN29zRnZXT3prcVU2V3pZRlVi?=
 =?utf-8?B?dmJRMm0zOS8rV1Z1SHNTOWxXWHV0dVZmNnpqdGRJL2xCUExkbFdocVROelND?=
 =?utf-8?B?clA5Y2tKa0taRklYcVpxUmdXYnJ3Z1AzUWRUUHJwMUlObWZkbkdZaE4wWGhG?=
 =?utf-8?B?UW1QNEJDUFpTRXdYTTJMWHk5N1lvaW52OXpyNzU1NGlUcEU4K1ZhSjM0VWpP?=
 =?utf-8?B?MjJwT1RMaWVjMlcza2dKVEVnQm4rUXArTzZPZlpHbE91S29kbzFWVHd0NU0v?=
 =?utf-8?B?enE1U21WMU83ZC9GRTl5d1lWN2RrZE1nWkIwa3RucDJwZEZ5dklkdDhnOWV5?=
 =?utf-8?B?SmlFU1pVWVFiL0tzbEdROTdId0lFM0h5QUNubElNK2l1WUNrWVNUWTFsWkcx?=
 =?utf-8?B?ZHduTFV2OTVJdUNmSENSRk1kaVk1Mko4NWRqVHlMa3JQRjZVY3FqdDVIdzha?=
 =?utf-8?B?WURyb2JnZEFBMnB0R3Z4eEo2WGsycGVYOUdmZmNnWG93MTlIZ0w4NW1URHdh?=
 =?utf-8?B?WFZVZFJhbDRxc0gxVnZLUUJKR2hoTVRHNExRMm8wbUNRNGF0dmxjSDFuajJq?=
 =?utf-8?B?ZndCQ2c4YzN1QW8yZ3RBMGl2YnFOR0JxREpnNG4zWE95TUEwQlBNSklzVXR0?=
 =?utf-8?B?azVVSEkrWjRPUUJKWURkT0VxOWl5allJaFdVZ004eTQ5ZDJyc2c0ZnhNdUYy?=
 =?utf-8?B?V1NaWlNZWlRVam5qM2drWERRbWlaemYrUk9rNDZMR0ZKbXdFMkd1RXhMS0x0?=
 =?utf-8?B?bFc3cDYxdENYNUQ1cmpkRFhxUWV1NUh0OUFyQzNQQ2Z2RU5WQkJoVHpzTjF6?=
 =?utf-8?B?Q3lhZWp2RGhwSzJZWjh6RWdXS05WLzBzWnJRdjEyaWlhK0MzdXVtcXN1VGQy?=
 =?utf-8?B?M0VMcmxITFBaUFVTRHRWV0RVazhNMnhYd3hmTHFvZENEMGF3SGZ6cHhVMUFI?=
 =?utf-8?B?QjM3Mk9QVXNUUVIzYnRwNGJJTEl4QmJUaGdQY1VOaGlHaDZTNFZrRzJrRG44?=
 =?utf-8?B?TkJJWjRjbVlyaXRlT3c0VnNIS2luQ0x6L0sveDNEYWhRNzRpSUwrQlhlaGh1?=
 =?utf-8?B?V2llQW91bndZd2hmdzFEUHpGWkJDbmFBVjhBc0M2c0YvTDIyaTJ1VElEMlE4?=
 =?utf-8?B?VjlEZEx1aTAwam83Z2VESGNzTGZlZ2VKbHV0TGdQbGl0ZlJSQS82aXVMVHl3?=
 =?utf-8?B?SDIvWXVvOEc0UmZCZ0NrSUpBTG9PVVNSWFdFaHcwd01QcHJnQjN2STdKZ1Jn?=
 =?utf-8?B?OTZGMHFPbUN2bnB5emZaMmxOSjMweEhrYTNCYURHTWpsa1Q1ZlE4N0VGYms2?=
 =?utf-8?B?Wk53cm9SWmpHNUtXNS9zS2czbXN1bVp1SHBGUUJMZmw2WEdHbTYxZEZzN3BI?=
 =?utf-8?B?bTFWTkc4ZytvV295K2E4UDVVZVE2OFBBK0RLeHc1Wk1hcGs0eDhMTWhwRFgv?=
 =?utf-8?B?TlE9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 668a6c91-b6cb-4e69-30fd-08dd1ea6cabd
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9550.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 14:26:27.3987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KEfmEnjQdwgv1LgcC1AOsZ255Yu+9qp5w4c3qegZY2xCH+L4Y+jNwQtVKRqPQrz8mZ7dKp025WML6LXUgnhDLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10669

On 12/17/2024 7:26 AM, Krzysztof Kozlowski wrote:
> [You don't often get email from krzk@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> On 16/12/2024 08:58, Larisa Grigore wrote:
>> Introduce the compatible strings 'nxp,s32g2-edma' and 'nxp,s32g3-edma' to
>> enable the support for the eDMAv3 present on S32G2/S32G3 platforms.
>>
> Not tested.
> 
> <form letter>
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC. It might happen, that command when run on an older
> kernel, gives you outdated entries. Therefore please be sure you base
> your patches on recent Linux kernel.
> 
> Tools like b4 or scripts/get_maintainer.pl provide you proper list of
> people, so fix your workflow. Tools might also fail if you work on some
> ancient tree (don't, instead use mainline) or work on fork of kernel
> (don't, instead use mainline). Just use b4 and everything should be
> fine, although remember about `b4 prep --auto-to-cc` if you added new
> patches to the patchset.
> 
> You missed at least devicetree list (maybe more), so this won't be
> tested by automated tooling. Performing review on untested code might be
> a waste of time.
> 
> Please kindly resend and include all necessary To/Cc entries.
> </form letter>

Thank you Krzysztof! I will fix it in V2.

> 
> Best regards,
> Krzysztof

Best regards,
Larisa

