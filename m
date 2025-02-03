Return-Path: <dmaengine+bounces-4256-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF065A25EC3
	for <lists+dmaengine@lfdr.de>; Mon,  3 Feb 2025 16:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7F711625FC
	for <lists+dmaengine@lfdr.de>; Mon,  3 Feb 2025 15:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEECF20469A;
	Mon,  3 Feb 2025 15:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="l7FluD41";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="l7FluD41"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2080.outbound.protection.outlook.com [40.107.247.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20762063C4;
	Mon,  3 Feb 2025 15:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.80
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738596697; cv=fail; b=lk4tiu4D18f8eajIKFAs6+xc2BUTIeD6s+ybeC09c6l4u7okfCHz/kHLSjGFEj3BSQJoB8SxKFtsRQEjlNSdOzb6BtnV2t3Ilhyq0l4DDCcEItP3NoL3cH2H0bsTtJczIaemttix+aaOUIZtNK7l8CXBbfMx71Hh30FxQMzLLtA=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738596697; c=relaxed/simple;
	bh=JxgPpA3I+q9C1mmfKTM3FNipzvv9ERNPIMi5kpxkyTw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dWoVCWmL+lxgCG/AeYS0zEKfXS5HF6z7jcE42FZ/eT7S3KPtBcRrkAQRjwQ1fRkOTRTCU7jooM3CGm2GEa8IFwDjbUAwC3pk9EvLPXdynbOhyOi2qEh0MhWtqa1SZtCae9p8+kDKxBMBlKT09VrvbDzmJ9wgh5Cz6B79kTTNRUQ=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=l7FluD41; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=l7FluD41; arc=fail smtp.client-ip=40.107.247.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=e7Td6UvJmtV9+E4+qUy1L71YSxMlx5Pi0QG+1j0NiiHbMV3tZSgc075Xoii3KKrF/G0uRdkGhxF6q2b2w6wPZ/eKADqCQQblAN9DfFhLqf7H0WWWRLJ9YWaZsX3D4TPtu0S66eaVLi/iJK9KWUVcvG0nicdXZRIVJ6uAnN1psSVbLnjJCPZGB3Gv700OGYV/PMj21D0K20pO9jzjibLncGEP85tKBwg9OmhSukBhAPWIw7VBsIjDmZWrKIhjhfl4yISft9d7wN7QmyhPMCuoEwuDdm5XMqmiDSxP9lY4lg+JwC9Qd+qoL2WyeLCtOWbAIUO8rVBOzVBMu31pBJg+Yw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0nK0w0HAzFrlWPzD91ZPBPln+P9sUVqwiuf37T5NAtg=;
 b=Acjy0RHDddm9/erh/0Qk0pRYzzFQNj/R63Ck9mEIXCIZgighB8RBXJxu9MMkSq77ZhZqqJABY7EarwwupvCn5yG0EM6sOWYMEMZCaKlru5u06gFfyDZFQj42KHb4MsPyrdsjhWhaExCFoWUaO41PYJz6v9bbjJhCwpwFkk6gQGmDsPZCoDj51AxCpWkhKTWv4HNz3esebTAZLwWQRXr7jxu8WjivZAyCXSyhyYsUO4VjE0Pkyj9myYtfZHoM9SgGy8G5EHT+sTCIocC3631uS51KfOUp3S5xxCBk3uzBntqVVS0jxpCXlh7cCTZYSKnXTqTNcMSGvQ3OH4jQ62yJ3A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0nK0w0HAzFrlWPzD91ZPBPln+P9sUVqwiuf37T5NAtg=;
 b=l7FluD41bmj1cjJhRW80a/4HSYe1PDzvho+eJbHZXaJMyZwrQYz6UxD2PBcX37WRUMJZhy3DLig7u4+AN8j33B9oeg3xlZRE6jEJi0JUu6gY5GyRzjIZD7Sb4TpgTnlNUwehvFji6tP1JFB4r3YRiv6PI7G1llCMyVRUsLH1Kjw=
Received: from DUZPR01CA0029.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::18) by DU0PR08MB9372.eurprd08.prod.outlook.com
 (2603:10a6:10:422::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Mon, 3 Feb
 2025 15:31:26 +0000
Received: from DB3PEPF0000885A.eurprd02.prod.outlook.com
 (2603:10a6:10:46b:cafe::ee) by DUZPR01CA0029.outlook.office365.com
 (2603:10a6:10:46b::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Mon,
 3 Feb 2025 15:31:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB3PEPF0000885A.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.14
 via Frontend Transport; Mon, 3 Feb 2025 15:31:26 +0000
Received: ("Tessian outbound 9503ad2ac7d1:v560"); Mon, 03 Feb 2025 15:31:25 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 95966970328cfeb1
X-TessianGatewayMetadata: Hzkrg6SFimyeSdVr+b5JYDJbrAh7J+hEzCuQKIAZa2ydquuZU/evovmx+uisTtB0Gc9Y9rs9W5DFogwcwdh6WVUBMywFuZki2z2/Qkcigo21lxUVr9by8K23GH8sK5BBY7ewgb1pe6ZrzqzQkmLkqgLcIP1ctFbfiUyBvJLD/fU=
X-CR-MTA-TID: 64aa7808
Received: from Lbb97d1179163.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id FAE934DE-AC96-49A1-92E7-7C4E5EC637B7.1;
	Mon, 03 Feb 2025 15:31:15 +0000
Received: from PA4PR04CU001.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Lbb97d1179163.2
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Mon, 03 Feb 2025 15:31:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qqD2yT871rHkyo9gLeXbpD22XsT5irNtJqHcRoVA9LfDGV1eTlcexU0D3Z3JDNfm5EvjcKlkbqH4qewYqvm2xs0eBvXiJjrXSgNG0A1YRmdt/WbREik29QpXPcj3tgVVWZ2+iykuCMdPKJLI06/WVRAEjlecFhG7OIsAjzPpMgvKz1HTM988GcKibypn2N/RNi9W8g9a8+Zi6ITsW/tJ7FDRD4MlB3Xd5DzJg0jY9bRloO85Ab1boqPs/Lxw2Y9/WyYdIQa02YMpH8E5HkI1RCzxCq8c5rlAVxUqRr83e5qQWVlS0LBMJcwyrwkDmJe6qfS4L4aOvZQWRscPTgQbLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0nK0w0HAzFrlWPzD91ZPBPln+P9sUVqwiuf37T5NAtg=;
 b=h97xNdZeT29H7gJEiqsnIRTKDif++pP6GviFgj8taM2vOxnoNerOM73Y31Bo6Ats3nPjO7sGDxOUf6+571sX8A49tqDZqLoi+pgioagUUsNTpFwqu/1014rDH7fPxsDfJ5gC17LC29x15eJBpq14UOTvF+U0ayupRDN2MOz42wdEs3NbsmB3CJRBsogK4+JRqxNtSEDGufblT7sob0RelrHKeY+ipxesJsV9b6bH1/ExaQPS3+QG8KVzci+bkiDqVDdKZjh0zdlhl7WYLeNigjPfzDANhv201gqr6UF0xwBciPlEZ1nsGKUnB8he/fg96Onzk8FhD8kYkIkACJoHmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0nK0w0HAzFrlWPzD91ZPBPln+P9sUVqwiuf37T5NAtg=;
 b=l7FluD41bmj1cjJhRW80a/4HSYe1PDzvho+eJbHZXaJMyZwrQYz6UxD2PBcX37WRUMJZhy3DLig7u4+AN8j33B9oeg3xlZRE6jEJi0JUu6gY5GyRzjIZD7Sb4TpgTnlNUwehvFji6tP1JFB4r3YRiv6PI7G1llCMyVRUsLH1Kjw=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AS4PR08MB7925.eurprd08.prod.outlook.com (2603:10a6:20b:574::8)
 by AS2PR08MB8285.eurprd08.prod.outlook.com (2603:10a6:20b:554::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 3 Feb
 2025 15:31:10 +0000
Received: from AS4PR08MB7925.eurprd08.prod.outlook.com
 ([fe80::8ef3:b027:e22f:1ea7]) by AS4PR08MB7925.eurprd08.prod.outlook.com
 ([fe80::8ef3:b027:e22f:1ea7%7]) with mapi id 15.20.8398.021; Mon, 3 Feb 2025
 15:31:10 +0000
Message-ID: <4b9deab1-e330-4c93-8260-75276c2bc9ff@arm.com>
Date: Mon, 3 Feb 2025 15:31:09 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/5] dt-bindings: gpu: Add protected heap name to Mali
 Valhall CSF binding
Content-Language: en-GB
To: Krzysztof Kozlowski <krzk@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 "T . J . Mercier" <tjmercier@google.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Yong Wu <yong.wu@mediatek.com>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 nd@arm.com, Akash Goel <akash.goel@arm.com>
References: <cover.1738228114.git.florent.tomasin@arm.com>
 <36b57dcf20860398ba83985e1c5b6f6958d08ba7.1738228114.git.florent.tomasin@arm.com>
 <7234f25c-a2aa-4834-931b-aeeb7a49dfa7@kernel.org>
From: Florent Tomasin <florent.tomasin@arm.com>
In-Reply-To: <7234f25c-a2aa-4834-931b-aeeb7a49dfa7@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0081.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::14) To AS4PR08MB7925.eurprd08.prod.outlook.com
 (2603:10a6:20b:574::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS4PR08MB7925:EE_|AS2PR08MB8285:EE_|DB3PEPF0000885A:EE_|DU0PR08MB9372:EE_
X-MS-Office365-Filtering-Correlation-Id: f3702e99-6a4e-460b-c885-08dd4467d2dd
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?aisxZ2MwUEl3ZGhxTVlmTmRMQ3Vnb1owVjJCNFFTRzNYb1J2UWdCRmt0V3Vz?=
 =?utf-8?B?Y1cyMHlSRmlJLzN5VXV4di9HQlNkc00xeUQyeWx1d1hwWEFwRkxhRkRHME5x?=
 =?utf-8?B?NUJWdXVlVTRUaml6MXE0elF4UUorVXRYeTZCNlFCakRPMXlOYkFRWmlMbXZY?=
 =?utf-8?B?djBXUnE3Q3NqaVpjR2RuTllWSXpvMXN5QTduWlhxQVZFM045VzZDWkRkejNk?=
 =?utf-8?B?VFBYZElUcldWMVY3WVBMb0d5YklhTEZodkRCT0x5Mzk0cnRDTThIN1lZREhI?=
 =?utf-8?B?V1pjR3V6OGJCWDdLRXIvNjNJaUp0UlNQdkcvc3JpWUQ1MWs2MnUybFFZRzUv?=
 =?utf-8?B?cm9KODFSVGJOaHM2WlZPQm1VU2ZyY2dnV3BkcWowOTNDei9PYjh4QlFHTTI5?=
 =?utf-8?B?empJTUUybmxTR2k5b1JPOGV3T3kybnV0TFNRMkZaYkJCQjc2T21MV3dhWHpW?=
 =?utf-8?B?OXhocE5ZSVZtcTJSVlRlZjZiZlkwSm00bXpkK2JYMzVWZHZkYWV6eTdRaGdq?=
 =?utf-8?B?QXFqd0lGZ2xXTjlXSGcwUWszVlRlcFA4TityMVRKRGtpK21JRWVEZkRXbkVL?=
 =?utf-8?B?MU8vc01mNGdJTDlFNUJHQjQweVkzQWg1Q0UvTUlldEZBUVV4MlY1MG9GZUc4?=
 =?utf-8?B?QnRwVGpscFJhTGhMUmd4ZE1iVjhvLzBvditQVEV5dWdGbXVIbDAxYXAvdDFZ?=
 =?utf-8?B?UXkwZmtNVEJnVktaN041aEVsOHZLY3FnQ3F2ckFRck0wcjZqb0hINDUrYTBZ?=
 =?utf-8?B?aFdUMmNPK1FqVm1QQ3JtaDBRNVBvVUxvUGFzbEh5TTFmL3ZETytTZktJdnMr?=
 =?utf-8?B?VHpTakZ5WEtqTkp2RnBDTEJQSitrUlRRbzJBQmZtbDIzdnMzMjhXeEJsNEVw?=
 =?utf-8?B?UFdvM2c3N0RVbDZUbU5rc2NETGNFU0doZ0I0TDFLa3RXUllWVlJ1UDdhWlJq?=
 =?utf-8?B?UFMrV1IzUnVES2tvejZCMnp2aWZZY3N2cEwyR3ZCTFp2ZVNwY25kbE5Kd2xt?=
 =?utf-8?B?anZUem8xREtvKzEzZlJ0ajVWUnN6S1dlZ055S3JzUk1ibFFRNzJMMk5vRG9s?=
 =?utf-8?B?R2ZYZElmY3JVRHI3NEtUVDhZTk5GdEtsKzB4VkRaWHp1T2xhU3Z2RndTMkhS?=
 =?utf-8?B?L0ZzUEEzRFNNWVVNWEVtVWJJOHZrVXF2eDJud2Z4Wm1YaVVtOWJ3WUhrNDhY?=
 =?utf-8?B?a0Jjb1ZuTkc3OUpKdWF2TnRTMWtGcTFEWVVnUnVSQm1memRIYTRNMG1hSlNB?=
 =?utf-8?B?RkgyYzNnb3kxNEl4WklzRXZpTnIxcUlza3AzMVc2LzRMOW1vV25PMko3Q0hX?=
 =?utf-8?B?R25BL0RzU1MzYnM2ejZpWVM1Skd6U0gxWVdxckpacTU0ZnhsTUlHdWM2WDJp?=
 =?utf-8?B?SnZ0WGM5UVpBNkxoMzVuYnI4Z1QzdEkvWXY2YUtvRllKK1FsMWkrWnpPQ1lq?=
 =?utf-8?B?N1o3SHoxVDdiQlI0aklEeHJ6dmU1T0JTVU4zZE5ZdWo4K0tLSHBqck01SWlN?=
 =?utf-8?B?VG5zMkcvYUt6NlhEZzU2NlFQMWVCZlBYMDh5YjZsYnVNOVRMdTcxM0dHK0Jw?=
 =?utf-8?B?eG8rN0xndjg3TlBoUk52eVlyUXFnWHlYbGFTWk8rbDdIb0ZnRkJGME9FUVdl?=
 =?utf-8?B?UURBOGg5RWNqUmNXaFB6aXMyaFk4SEJsckU1OVFvd2x5UEllZHJ4RnYyVVNj?=
 =?utf-8?B?aVlTK3JMb1hkeXNoSXFpTUtFZ0JnOUxOUlgxSHNkK3QrK2d6akdPMi9Mazl3?=
 =?utf-8?B?MzIwK0pidGNkQzN5TjAvYWNmK2VHd3dHNmxtKzJob3FTK0RqRkNmS044dVly?=
 =?utf-8?B?bElUZGhSWFJSREpqTHZVTzIvYmRoYjM4TENaaFNtWXhpNUdxK0RPUHNtZ05N?=
 =?utf-8?Q?e0KAlM40Lz9ba?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR08MB7925.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8285
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:20b:574::8];domain=AS4PR08MB7925.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB3PEPF0000885A.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	45da9d79-a0d2-4621-5c35-08dd4467c94f
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|35042699022|376014|14060799003|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UWFka3M4dy96UnZnSW81ejZ0cW1hcFFNWkozeURTRHBvbTFCRmlrMFVxY2xm?=
 =?utf-8?B?WnptQVB5ampMdmppYmFiSDVudWlTY1luUSs0L1Y0ZXpWMmVIRUZxalhrWktR?=
 =?utf-8?B?L1NNM3hpUldpTHFMT0tqWm9rdzNtTVR0ZFVtNmJ1Qm1hSEJibkd4aDBNVmZL?=
 =?utf-8?B?YS9ONWl4bHpENnNqNG5xaThIbjFlUXJXV2l5Y2dDT1JRRXk4M1ZkcTc5QklP?=
 =?utf-8?B?cHl6N2daMEVOTnFiTUoxNUw4elZCbGlocmZsTlhoSGJjSDNTNjd1N1gxWnVv?=
 =?utf-8?B?TDltNHBtanV1MUIrOUsvV2FpUEZmTk9xa3FhY1JXQ1ZQUmhlanF0cU0wLzk2?=
 =?utf-8?B?MDQ5RmhOT1BxNEFoYWJTWG1waDNpT2JVUkNjOXkrQmQ0TDJUaWRac3JRZ3hY?=
 =?utf-8?B?N0g1ajA4VkZDbnVHcllHbkhvZWpZLzlKYXlpcEx1c0t4c0YxbXAycTViZVJC?=
 =?utf-8?B?bDl4TzAwYm1QdmxqZWtxTWNEYUdNdUJ4NGx6UmQ3YWozODlxeHBIZ25tWTBD?=
 =?utf-8?B?cXhlMnVsbzhqS3FMN2xLbUVUcVV5c3J3NkIrRWVGREliLytTbHVLYkNKbTVn?=
 =?utf-8?B?SFV4dGdRSzNBOTQyM0VjaEhSaUtHZ09heG8xUDQ3d2JuRFk4ZGErMDJySjNU?=
 =?utf-8?B?elFWemt0N3NzczBXbVRJNVJtYWs5VWhBREhKTklPSkF3Z2lsRUdHZy9KTjhV?=
 =?utf-8?B?NXBvR3I4dy85S1pkOU1MWUlDL3VPRnZZbU1VR3dtaVpPZG1RNml4aGRnU3p4?=
 =?utf-8?B?K2ovVVlvTjJ3d2VDdjhjNGY0ZjdmbnhBR2RNTW5ycDl5d3k4Rkd1Rk9SMUVU?=
 =?utf-8?B?ZHR0Y0NjZGROUXZSQVZVeTNUR2pTOGdRanBHcUI3NjBEQWpqUk1PSXRRR2VE?=
 =?utf-8?B?QlZOZ0h0c1pMMkZQelE0SkYxaElYRE53K3d6cjVKWTFBMXNUa21Bdm1UZURo?=
 =?utf-8?B?NVc5ODlTQzArdHVmcW0vUWI0YjcyVUF2YzNBanBFT2N1bGUwK3JSWDVaUVh6?=
 =?utf-8?B?LzF3Z2RlV0tITnhmcGNXeVMrZFZlOWIwY3AwUHMvTlR0QWtHWFdIWHJ0ejI0?=
 =?utf-8?B?SXNqdFVBRU80L3I0V01DQ1htRUFZeVRKWDZiUWh0eXZydDlGb2NBcnNSYW5S?=
 =?utf-8?B?VXhYS0V4MTVNQ0lleUh5N0R1MGREbzVYdnc3T2dOQWtFVTZ0WmNNbDF5bjE5?=
 =?utf-8?B?cXRPelNWTlVJNmVtWFd5ZVloZXIzZU05OWdhU25scjBES084SFc0UDl4VFoz?=
 =?utf-8?B?RTAwR1dkVEFqaGQ5czFJbDFYb1BpdUNHc1dMQ3RwTjlWNDdZd0s0Y0V1LzJu?=
 =?utf-8?B?dEpoNFdQNExVV0ZGamZ0dExxQnMwZXN6ZDNiT2U4OW5aVndZRmpNSWFPcWF4?=
 =?utf-8?B?bmI5eTRqb1BsLzUyTXNDZDlxVnFPN0ppSDRXSlEwQlI5ell0Rm1TZExEUXVS?=
 =?utf-8?B?U2l2K1JlRDZIMVJNZFNFbTdsblRXenRFeXh2T1FZR0ZQaGs1cUdkMXdtMmhH?=
 =?utf-8?B?VXV3MHB3cEI3R0JhUFdQVkI3OFJVRWxhNzh1UkJldTFreHd4aUxrYTVzVThM?=
 =?utf-8?B?dk1scVJ5YkNuYzBsQUU4bVo3Ykd1MjF0TWZDVURBeE9TbmJjMlVJNktWL1pN?=
 =?utf-8?B?T2owYlQ3OENrTHNFNjJZMVN3ZDBWOEhlUXpyVHRHTituVEJKL0gxR3NUcGw2?=
 =?utf-8?B?L2RkVmt5M0lNYkFrM09Pc2U1T0RLWDdrMkV1TVZ3bDF1RXp2eFA3L2pTZ3pT?=
 =?utf-8?B?azdGNTV1b25LclVwUmQvZXhtOC80KzFJOFVEbnE2eCt2MDN5TXBMWEpIRVpx?=
 =?utf-8?B?TGM4V2grL1hJM3BqVi9lRU9tWTJWNVhrQ3VtS0dMR0pRc2ZVQmNhdXQyVWRB?=
 =?utf-8?B?TzRuNjZPL3BsWS9GRHdtYVBJOFk5b290TnJ1U3ZPYXVXMEIvVjgycmw5dG1j?=
 =?utf-8?B?Mit4RkZyZlNsUzhnalhEQnJ3clZ2MjIvVXVJQXBhM1lkbUttYnZQYzJudVEw?=
 =?utf-8?B?elJ1ckptYytRPT0=?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(35042699022)(376014)(14060799003)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 15:31:26.6390
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3702e99-6a4e-460b-c885-08dd4467d2dd
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9372

Hi Krzysztof

On 30/01/2025 13:25, Krzysztof Kozlowski wrote:
> On 30/01/2025 14:08, Florent Tomasin wrote:
>> Allow mali-valhall-csf driver to retrieve a protected
>> heap at probe time by passing the name of the heap
>> as attribute to the device tree GPU node.
> 
> Please wrap commit message according to Linux coding style / submission
> process (neither too early nor over the limit):
> https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597
Apologies, I think I made quite few other mistakes in the style of the
patches I sent. I will work on improving this aspect, appreciated

> Why this cannot be passed by phandle, just like all reserved regions?
> 
> From where do you take these protected heaps? Firmware? This would
> explain why no relation is here (no probe ordering, no device links,
> nothing connecting separate devices).

The protected heap is generaly obtained from a firmware (TEE) and could
sometimes be a carved-out memory with restricted access.

The Panthor CSF kernel driver does not own or manage the protected heap
and is instead a consumer of it (assuming the heap is made available by
the system integrator).

I initially used a phandle, but then I realised it would introduce a new
API to share the heap across kernel driver. In addition I found this
patch series:
-
https://lore.kernel.org/lkml/20230911023038.30649-1-yong.wu@mediatek.com/#t

which introduces a DMA Heap API to the rest of the kernel to find a
heap by name:
- dma_heap_find()

I then decided to follow that approach to help isolate the heap
management from the GPU driver code. In the Panthor driver, if the
heap is not found at probe time, the driver will defer the probe until
the exporter made it available.

Best regards,
Florent

