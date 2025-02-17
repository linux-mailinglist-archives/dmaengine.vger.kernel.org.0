Return-Path: <dmaengine+bounces-4510-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF567A38774
	for <lists+dmaengine@lfdr.de>; Mon, 17 Feb 2025 16:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53398189397E
	for <lists+dmaengine@lfdr.de>; Mon, 17 Feb 2025 15:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B902248BA;
	Mon, 17 Feb 2025 15:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="scIyuNwT"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2234D1494DF;
	Mon, 17 Feb 2025 15:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739805926; cv=fail; b=jifqWWQjDdzgy0qPHX2mTqyiQm5fk3TftbVW1YBs2iJyeOjS74ly9kJ+CuP6VgELgk5rV92bJQYkJ24TdMeJpC5yqfXxyBQfvPJxOJ98sq32J1HzS9KN+gwEcCrdOU4+fC8DSgo16LzTM1Q4Ic+ImGKqWtI2YDVzci9NAgIvZYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739805926; c=relaxed/simple;
	bh=IVgWu6ixYbU8E5W618sDozGrOpO1RxPiFWxCzEmuPV4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H3gjKnoq9Y8Fd3fX3okWr/FOOWuc5BHhB21YuLa0amakmm1/hwd7Vp5eZ9tzb4rN6pkjcSjlGWFwc8mk80+M5FVuij5Q4Z/iCcrdaaLpYu8qnLaFcN60Vwo8ZghKezzzAlVUCMsLzHy2BUVleOtd2TE0BeTYBsR5b9/c+TZ/xCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=scIyuNwT; arc=fail smtp.client-ip=40.107.220.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bspctL1ghDIBPpVOHCn80k5ReoAuwy/dSuLOSYFS359spHoNoq3iJ5zOZ0LxfEGDP1RFpF/jwugcCWoLhxPlN8XzNXc5jP6o9xbICf2QP+GW6Kxi2TuRy3YAf71/gaaa8ifH9aVR7wFMDSNza2APOEpybE0Ip5zzIRUYZzpJAjLuycy5NsFCz9DmhgyES5Hu1Kn3HhBgV5ToGDt1AZ+LEM5aJJcmSOBKvp6MQdpTreOC5m2W1TTJby0RVA5Pv2++v1dlGWKbnv39Zfq7RdJ2i28tvJAQ09kVExgNK72I8R3CnOZDO4VAxwSoYo5daizH2ib3oqA4+WkB3xUD4xwwLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ueM8m9rQe+uR983jGywqvg0MMLOxb4NHnpoyp+iISZc=;
 b=OcSOpSAw5nJzy/9Mg1mR1qyHiIBus01KbiwMS2CKIsUgkqK/6JLaz+ZU95hcHIAqO9XYybnEKhPttRVQONkqplfZWN1x5MjDSkhJElwmNZHnur6G5nc05O4EJpaWLZdiVTTHxGHinRjT8cKIenSKIf2MqM/j31ozpQqM1vOCs+hf2nppbzMESoUoR2bG/j+iKA8YjAcoOjMvIBo2/vIbonWFMEAfK0gOiWKPFAOquWR4xTD+2V6SoUzGRSihMrNV2ugIlGGtpd45/vF0ePgrPT+EYmX8p6TyQrDoEjIOTsxnHOUNkeFrt4V4iQASP0ZiNDZrpsUBEGLk93yXs7N7hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ueM8m9rQe+uR983jGywqvg0MMLOxb4NHnpoyp+iISZc=;
 b=scIyuNwTFJR4RoHl27V7LTDz0K9LWsuaLhPSUnHdD2c7AIdwWMaKz9sqcj1yC0oiJOLresmkTaFLUAxHKixSkvfgKKcrTvyXZDQcTH2ahh8ciU2p6VlR5/Y5Lb4dDliyjMRH+wEc86GjCIPlI9yt/xyAVe28usgGPy9+6lK/FEo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.14; Mon, 17 Feb
 2025 15:25:21 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8445.015; Mon, 17 Feb 2025
 15:25:21 +0000
Message-ID: <db3af9b9-37b9-4a29-a480-ddb1df497530@amd.com>
Date: Mon, 17 Feb 2025 16:25:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] arm64: zynqmp: Move firmware constants from binding
 to platform
To: Conor Dooley <conor@kernel.org>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
 git@xilinx.com, Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Conor Dooley
 <conor+dt@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Harini Katakam <harini.katakam@amd.com>, Jakub Kicinski <kuba@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Mark Brown <broonie@kernel.org>, Michael Tretter <m.tretter@pengutronix.de>,
 Michael Turquette <mturquette@baylibre.com>,
 Mubin Sayyed <mubin.sayyed@amd.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Niklas Cassel <cassel@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM"
 <dmaengine@vger.kernel.org>,
 "moderated list:ARM/ZYNQ ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
 "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)"
 <linux-ide@vger.kernel.org>,
 "open list:XILINX AMS DRIVER" <linux-iio@vger.kernel.org>,
 "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
 "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>
References: <cover.1738600745.git.michal.simek@amd.com>
 <20250204-onto-gliding-465a003ae66a@spud>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20250204-onto-gliding-465a003ae66a@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0037.namprd05.prod.outlook.com
 (2603:10b6:a03:74::14) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|BL3PR12MB9049:EE_
X-MS-Office365-Filtering-Correlation-Id: 55e1b035-49e4-4b97-1411-08dd4f674aa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YytGai8wKzZFMVdYNytzODN3QWh5NStxMU1QL2xGY2dBMTlmMHBmdTQyZm00?=
 =?utf-8?B?UVNhVHVrVjdpYW1DMkVLbnZOTTN6czJWZG1rN3FYOUhBNmlwN2crMUd0WUl3?=
 =?utf-8?B?Y1JETkc1RmpvQVFMaEZvbkFpVEdSMFNYajVFN0g5bXlIQ245c084OGNiYWpx?=
 =?utf-8?B?aUZvQ1pGQXdRNzR1TlQ3d0l6aEZxVTFweXJqNE5lenlheklXU3ZJU0kzY0VH?=
 =?utf-8?B?UzBvbW9peWhRazI2S1Z2MlJFb3l5WGJHdDY1QVhaSlgxaHBDZ0dUaE9sUEl0?=
 =?utf-8?B?OEs4NXMrU0JJTVV2RkZ1dCtMY3RiWExTSytQdnp6dDVjcjhoZU10a3lIbFQ4?=
 =?utf-8?B?UWtBKzdlNkRIdXN0WThITFJkbEYzbXU5MStjU05CZFcrSk1PY3lzV21ScHY0?=
 =?utf-8?B?K0ZFOEZ0ZFVLR004K0NPSEJweS9zUE5mRno2djdsVURvZzlxMWxCNFR1R2Vt?=
 =?utf-8?B?SDQ5RmtNSWRucm4vNjgzbGpVQmJ1dnpZaHg1MUkwV3NaTGJmbUVBcnhkTnJD?=
 =?utf-8?B?d3RsenFJL0t5SG9uaFBRWnAzWjNUZ3ZoY0czT2FIVEt0YzkwY1A1SnIzeUVW?=
 =?utf-8?B?NzcyZDVEcXU4dU93ZEtOWnRmV2RMY3dja3NSV1hTLzQ1WWg4bEcrajdmeXFj?=
 =?utf-8?B?TnpIaVpJTFRGNFh3bys3UkY0TTZWaUpaZnRzMHhZMW44a2ZOMlA3T0F2UmdB?=
 =?utf-8?B?SExYb1lxSzdST093bEhrYnBsYlVQRGF1Qkh5TzAvcGZWYTFkZGJGZXAyQk5M?=
 =?utf-8?B?OEdsY1hNZWxvZXJxR3R5NWhQcHJ0S1V5Q21zUFh5bHJsMHFxd0t0cmpHenFn?=
 =?utf-8?B?YXJxKzl3ekZlNmg3YnUxbWRYMnR0a2dIYjBlblRQTWh4TmRkUEVvU0NrYmRS?=
 =?utf-8?B?bEtkMy9sczE3dEllSEdGZXdMN0JMaUdQVlJDc1pDbUVFNVRBdlRQNEhQN0JS?=
 =?utf-8?B?L1dUZk1hWkE2b05ybm41bXJ3RkZPdkZsYzhRZGl1ZmQrZEoyQlQzZEtsQ2Zq?=
 =?utf-8?B?SHdnVjRzdy9jbXZxL1p1ZEExd2ZQTU9pL3d0c0tCL3RoLzNMSWcxUTZicWYv?=
 =?utf-8?B?WEh2eUNVdUJWNUVuejZFTmtrWC9qM1J6UUYybFBQd0RYMk5RRDBVWUxoV29W?=
 =?utf-8?B?V2w0N25LU1pRNWF4Q2NEbllsRjJZUUo1SkJ2OXVlQmgwdmNhNFlmTlpwUjZs?=
 =?utf-8?B?d1BxeXBvRThQK3BBdnpNNytKcUZpRE5RMW5wS09LVDNwVTJWWjArUi9kM3l1?=
 =?utf-8?B?eVpvcm42dmo0SFdSdlZJMC9jMjNvc2creUk1T0o3VFROWWUraThxUWVEMlNy?=
 =?utf-8?B?NmtZRFV6RmNyMkxpZVRvS0NFZjRPOFZ4U2M0UEpWZ0tPTzFRYUZJa2NsV2JY?=
 =?utf-8?B?aXJybitQTEZpRTRHODZNL1BsMUNMUjdoTERWdVh3ZVFaMTBQSWhPakRZajJV?=
 =?utf-8?B?bXhuRFo5VmpxalUwcDhjUlR0VGFuZnlyVWMzS1BNUDdhT1h2TEg4eC96K0Qy?=
 =?utf-8?B?MXJUenJrd2drUDAzWE1LQzU4Q3R0ZDhJbHNVbVhabjVwNmYxRm4xczdabUI5?=
 =?utf-8?B?cE9QdFNtaUhra1JTTHZsSUtEdFBxdE5nOTJHWW9zc0RkOElWeHhZenN4bGw4?=
 =?utf-8?B?eHNobVRQL3R1dlBmSkprdXFwSUFScXhPSmtuWTA2dTVYbEUwWms4cEZTMjJw?=
 =?utf-8?B?Zk1hWmdPSlFFd0xlSlJBQXk3U0JCYjZaRHhhRXcwQkFIcHJ3T2RwdHVmeXFu?=
 =?utf-8?B?MDhxNzZMejFZRkpxV2NuKzRKL2J2VFBXSGN4cFZzR2hJV0FPZ3hGTXhXRFdO?=
 =?utf-8?B?VTRsZW9sU0FxaHZnaFhaQXRTTlRROWdmcUNyYldvb0ZSdW5KZ3o1ZTk1Wk9X?=
 =?utf-8?Q?d1UC95onacDxi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VU5mK1pOYUZkUXpoQThCY3lxOVhwazNFSDErRTdEYjRLc1FpWlJXQmxaTU51?=
 =?utf-8?B?K1JXVzlkcitEbk9acDQ4eURBKzl4WHNsc3pRak1HeU9Yby8xcnMzRG9scC9h?=
 =?utf-8?B?djFIZnFTTzNZbitLQ1piekFTa1VVRGdOWnFnT2d5SGlWcFNFcG5JMnRUbkR3?=
 =?utf-8?B?a3Z0VjY0YmdpVjNIVGJjS2pWdmNibzNaZXhCWlhFVWJuSkE4LytmWnc1b1da?=
 =?utf-8?B?bEpOVGhMRDRyLzZ6U20wUVdYNnA0U0VXSFVmbE9DbHhlYzMvRm53eWUzSE04?=
 =?utf-8?B?aUNEMkVGWXpEU21XcHk2Q3ZLSmE5WWQzbksvRUVjd3I4L2M1NG00cm5sQVpn?=
 =?utf-8?B?Sy9YaVpJVm10NzdlRlZrOW5paWFOREFHcmZ3VGpyZ3hsT1IzK1VlTzBGcTgy?=
 =?utf-8?B?ZGpPaDdaVWx5Rmsza3RMK2k5N29VdzFvYzJWQmtXUjdMOHNYOE5NSzRuaGFC?=
 =?utf-8?B?aGNVTnVHSGc5a3lwNHF0Ums2UnA4Y0t6cFNwTWVVcVpIODQ1RWs4QUptSkdP?=
 =?utf-8?B?eWh1K3NJZnltQkVObU5la3A3Yy9tZ0E3OUFnZ1NyeTJDSkFUb1pRZmQxRTd5?=
 =?utf-8?B?aTlPN3hiYkMzSS9BN1hDbit2bThvd0hnYnpyS1ozY3ZBU0VyK0UxclZiajFY?=
 =?utf-8?B?OVRqL1lheDk2MUtrTXpKUnNQYm5DcGYwZGxRbkh4RkdwVXhUYThyR3RFREJS?=
 =?utf-8?B?YVdYVzlTZE5zNm54S0M4eG5iMm9IOHhjZ1VkaC9OdG5KYlN3N3pxNmFvQWpI?=
 =?utf-8?B?WURQT2xqeEtaY2VQKzA5NDBSSlVnM2NvbktuZjBJazBmVDZ3LzFlazB5RUpE?=
 =?utf-8?B?c3hITlQzaHUrQU1wa2tSZ1IxMkxPN21CS1I1NG83eTlHek1BUG0zS1VsQzFJ?=
 =?utf-8?B?NDZ5MlRKVUJRWW0yK2dkREJ4ZUVzQmJoOGtlTFVPTSsrbVE0czlnOERnbThC?=
 =?utf-8?B?c1oxeUtHeDF6aGlQR3drU3F4S1FQaWVnSXpGZVBJajJyS1Y2K3dRSzdodlBn?=
 =?utf-8?B?V2dxQTFOM2ZiR3hqVC9PNmI3OC9oVXJ6MGg0SDR0QUxxUGxQb0tvWnlHVkR3?=
 =?utf-8?B?b1drZmNJd3BHRHo2WDBzN0w3T2xwWVFlby9LVG9COWpBdi9OWEhjeGl1QWts?=
 =?utf-8?B?a0I0cHFjMjRwdkhBWUl6T1lFWnBtWlMzYVN5T0N3aThJWnA1NzNVSHpZOVlu?=
 =?utf-8?B?ZG1Ybmdndm1UY3Y1SGRmRUxMWFhTNHVpM0haUXhqVTFZc1h4aTFVSXJYcFEr?=
 =?utf-8?B?aFZ1ZXltN3docG94RUx2VENkdFJYYVJqaGZRamxkcEtLcmd0Y1FheEVkRmhN?=
 =?utf-8?B?QWdMM1VOTngwVzBsWGhVVlMxMlZSMmxCQ1Q1VUkxNW5mYTdzS09GU3ora3Zx?=
 =?utf-8?B?c2o4b3dNRThHdFM1dGw0Q2M5dllmNVdIaysvY0NoN1ljRVZlRzhOZkVuOEdP?=
 =?utf-8?B?ZEljUFR3dUtzbktkdGtPY2pqZzZ5ZVFKNGVqZjdNOG1FcVl0anNYZnV0bHl2?=
 =?utf-8?B?UnIzR05BYXM0cXEvOFA0NDNOR2txUTRRNXV2TUM3ejkxNnZRU2tWVHFJZDgw?=
 =?utf-8?B?aCtjMVNUd3hXREZGUmZBWkFzTHBBRHJYSExDanBPWmt3ZHI1QXllMjdCVnJw?=
 =?utf-8?B?SUJjaVM0QTdvbGN5OWllVWEvZlNDQzB2aFdkazRTU1ROekh5ektqdE9JRHRE?=
 =?utf-8?B?VElzQUhxclRTYWxMcm5YeVVhemRUOFMrLy82QnJaa1pzdHZ6c0V0L1ltUEJl?=
 =?utf-8?B?QWpkb2tEVE9wWkM5WXFZTGIrT3BGZFRZTHNTZHFjMnFrMnRIbFhqUTVUcUhM?=
 =?utf-8?B?UlVZeDc4YTJ1L3N5OHNIVzFjMDdrTnpEUWVlL2UybnRkb0NtcEJ3c3N3MVkw?=
 =?utf-8?B?YW9tbmg3TEJlRWFIaExUNW9tUEJZRWNtTnlTZjBZc3NQV3pEM0tQVWw0MFlo?=
 =?utf-8?B?WVVyamt6cG9QMXkxdjdyR1pudUEvUmIvSmE5YnhDVDhMQy90cnJ4SjJOUGJJ?=
 =?utf-8?B?dTlQeDlzcUlNTVJDUy9YVlhWQmVsSlJNSHFZR2ZXVGN3a3BQY1pEekNPOTB4?=
 =?utf-8?B?R0NIeHNGOHppR0tuODlKdlhhSHBRM2lWRC9CWWJGQ29iaEhFdDhJS0xLK2Rq?=
 =?utf-8?Q?FzTDvD83DmI8vPKSexVk71bYM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55e1b035-49e4-4b97-1411-08dd4f674aa0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 15:25:20.9949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jmeZQwq68QeZ39V8LN2GrsF2INa6/l6U6ys1SNyMfTd6AoltIaYPFM/TbOE2UY/6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9049



On 2/4/25 20:43, Conor Dooley wrote:
> On Mon, Feb 03, 2025 at 05:39:09PM +0100, Michal Simek wrote:
>> Hi,
>>
>> Based on discussion done long time ago
>> https://lore.kernel.org/all/5353872c-56a3-98f9-7f22-ec1f6c2ccdc8@linaro.org/
>> it is better to deprecate firmware contants which are not used in any code
>> and it's only purpose is to use macros in dt files.
>>
>> There is no reason to be the part of dt bindings but it should be kept
>> there with adding deprecated warning.
>>
>> I want to see if this is the right way to go. If yes, I will also do the
>> same changes in other headers which contain only constans which are not
>> used in any code.
> 
> Ye, I think this is a good approach to take.
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Any other comment?

M

