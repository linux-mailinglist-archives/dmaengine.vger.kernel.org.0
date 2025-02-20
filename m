Return-Path: <dmaengine+bounces-4545-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BABA3D87A
	for <lists+dmaengine@lfdr.de>; Thu, 20 Feb 2025 12:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19B173AB64E
	for <lists+dmaengine@lfdr.de>; Thu, 20 Feb 2025 11:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6211FAC29;
	Thu, 20 Feb 2025 11:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5Adk4Vp0"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178811F55E0;
	Thu, 20 Feb 2025 11:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740050498; cv=fail; b=UpZjXW7dkXWgNynMQRyTAIgVrCg8Jtf8IlKyw4tRIDbDxwDT/55Z82eg0h7PaYVT13YIzUoRtxhYkNYc9L2LbVuoeH5DgvxRaP534/BaeeahywhRPScc+6YHWjCvcH/LZopHYuQPN2VeD7jjBM1fV4qXJcA6haAQrGirrZcHcvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740050498; c=relaxed/simple;
	bh=NKogL3hWt93SEZn2iceD7aUkZ4kAv6wJ5foX86vvkZc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g7LgKbA5FzhdP//5l7kFhyvkYrAAUO34/uFZsHiT+kZP9fJRtOKfPZ4mRib8mcTCvVkyEWQ8alkfVgVHOU4PFicEcNL90J7zKzIqyUQr9RJ0z8VUGZjRgaY5cHBX0dtmxd80cOyNymdEksXCkP0Mgih5NIFgNeMqNwd9CRPjZC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5Adk4Vp0; arc=fail smtp.client-ip=40.107.93.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=He9ZRfBMjjppP+Ar6UaqpBdTeUPEqH+OVdWZowDE5DF9ol+dlofBTWYBbrPa6q8JuICHzG5woSVU55V+423IUnqVHMLV4qcAYfxik5p1EMIYXAsyXWs10oS+8bwdul59Unm8LgiB985jt/7/6JliB1WoDcPFxcID73+BAB87o9dwXV7ZtWz2BtCmkOhid0/KpZwm/bAHuXHin38BSKRiBHFAsq2YttJnsHw5VuZ/8bj5fLL/RcmrWtz2BEXvAYP447KFrKAU0yp/539yWxEvEyMF3MMhGsgQnrGRQXNDQfFVsi6yzoIuIVyaGgl/W3MDi5f0GrUpF4omw4nWrd7+aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0EUJPCy/QJLXScGreVlHhvceI4fMku6xHcIDtEi7my0=;
 b=RmQf6gQtOdBa/eNZE7V+jaE5G5U0v3RpxKjmNWEI8amX9We+izBWYxXO/6G/5hqXQTwc7dcNRHDQKdJme7duaLT4EwsLl7gEmTFE5sHn221FWPdKUrCjQaPP75lE5EbUebkx09MrufPueofaRqViMm02FHa8O95nTsQxF93K2Ng+YNIgXMFOhrFWfwD0eE9pAwy4S2sDKj2Bmeq73QHoyDXbsMPQcX3z+3LBX4Bq+xQXDhTxARkTFHjQvn3SAkFn5PZ0p37LapNn1+ovxhJ8Vhqj6eze9Vjp9PYN0rf1jriC6Qf6LFVKKsF4QoKfDoikz5JGFvJ10QCa8ykR/+KtNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0EUJPCy/QJLXScGreVlHhvceI4fMku6xHcIDtEi7my0=;
 b=5Adk4Vp0nsNhxzVLvIZO/3iFvQ/1uxMcVH9khra+n2hQT0zfBUv7gVRlYf0hb3eowPF8pSf0VAgqSPbMMM1Ef0t1O6VWYaV+Zn+xSA/3bi6Zx+5nfw2iZ1jneaUPI8b/eigWqynONvZQwgGOttcJAi9phGgDTwTLldjl6lrV36Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SJ2PR12MB8034.namprd12.prod.outlook.com (2603:10b6:a03:4cb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 11:21:34 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8466.013; Thu, 20 Feb 2025
 11:21:34 +0000
Message-ID: <8dbb5f6b-9c40-4b79-a288-679e9b1d65fb@amd.com>
Date: Thu, 20 Feb 2025 12:21:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] arm64: zynqmp: Move firmware constants from binding
 to platform
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
 git@xilinx.com
Cc: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
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
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <cover.1738600745.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0022.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::32) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SJ2PR12MB8034:EE_
X-MS-Office365-Filtering-Correlation-Id: b4e183f8-fa31-422e-0440-08dd51a0bbdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cnJ0ODlSZGU5Nk5od2ZiOWY5TWppMi9nQlJCWEJCMkFkUVlTRlFpUis0NjMy?=
 =?utf-8?B?T2tJVm1hZEZyNGo0Y3ByS0lGdDdjaGtCaDNRbDVVR3Nsd3FrbUVxankya0tL?=
 =?utf-8?B?MkNFRGVPNHU4MEtpZDFVSzAwV2VYUTBwd1c4Z2JWVlhzVWZoUXArdE1xZlRi?=
 =?utf-8?B?STFINU85VS85andjSTZPYnh0RG1SVUFtV1JENVRNRWI1TnQwSURHanc1aWVS?=
 =?utf-8?B?U3ROZ3RQcEVwdGVvb3Y5MlAvNFJUZ3lTTk5SU1JvSFR0ZTdPdzREdW1raEhX?=
 =?utf-8?B?ZDhnSzU1dmpPZ2t5Z29JNnJDNjEva0psQS85U2lsMUkxeUJLdGpINEFnUDRG?=
 =?utf-8?B?bTFnYUZ4YTN6V2NrT1cxQXZ4SEZtMi83a25oZmJoOG5ObW9iMmJOS25lOWFZ?=
 =?utf-8?B?NE1ENUdhaDdwaGFZaUZWZG5GbmhnQUxiZ3ZSMWJjamo3YWx0UUR2V25PMFdD?=
 =?utf-8?B?a2grMXNnOHNvRWptTk5maGNrbjEwS0oxd3ZZb2FGSThCTVc1OUtPMWVPd255?=
 =?utf-8?B?bXpEWUc1MmZ3K0dKU2tFMi9aT3U2Z1U0b0VSNm94UEtvNkhXbXIwdHp2Y25a?=
 =?utf-8?B?aW5HVmJ2Z2J2SURIZmI4c2hUWEtsc1pkak4wNS9zUU43eTJpbGtSMU9xYytK?=
 =?utf-8?B?OCtXc2NvV2pIYisxaGdkVXJjUWI3Zy9RUGFldjQwSHhkem9aOUt4OGcybEhY?=
 =?utf-8?B?OWJNdGNSRGdxR2lJS1hCVWZJODdRSlFuZVBMd0dnUmIrMzAramhYWnJCODBW?=
 =?utf-8?B?b3ZldGphQklRd0dDcEhiY3IwS1QwTzBHSzhndlBLckxYVWt2VnBaY3V6S29m?=
 =?utf-8?B?QUU5c2tTMFpVWm5ITWpoV05ycWx2VndVK2ZhaFB5WGQzSlFnZHRWVEU1eTlv?=
 =?utf-8?B?KzEzWStrWmJ5QSttSFprcGdUY091cVVKQnkzV09LRHBQZi82am1waHBtclR1?=
 =?utf-8?B?V0kyR2NqOHNHRzNsVGtVVnp2K2dzS2JSRG5CQzYxZmpHbVBDTkNnQzR3TDBK?=
 =?utf-8?B?NEY0aWdPYVJhSlBTS01lRkFiV24vcmFvWnFwaGxpd2Vsbytidm8veFYzUFQw?=
 =?utf-8?B?VHhNK21HT0xBTCsrcnlKNTUzUHZwU3J2YTJTVm0zeGVqbWFhaVAzSndIWkJP?=
 =?utf-8?B?TjJlWmtNN0NKellXZjFCeG5BYXJNT2hHcXpDMkVtb0w0WWdOMDRZWkwyOEc3?=
 =?utf-8?B?SlI5Um0xazRvU2RKQjVWbFNiZDBtSHUzSFF0NHBDNno4NWlsaFF5cGZhd1kv?=
 =?utf-8?B?NkJjeGRtQm5NVVRqUGRyQStDUitrZko3WmsyYWJjOW50UGNYaUdUKzcxeGxM?=
 =?utf-8?B?OVhWbWJaOGtOR2VCS3FlU1Z2UFQ0Tll2MUxhUGtET0hjMXl4RGt4eFM1RXpO?=
 =?utf-8?B?eFNWYUdCVXUvUm9xZSt0d1BDZlFjZjF0cmRRalUvdTc2Sm0rSmtlamtMakYx?=
 =?utf-8?B?UjJ0eVNjSGtsZTBDQ2t4ZGpCencweWJwMVRYc2tLaEk3Q3VxalJQbnVrUllo?=
 =?utf-8?B?RHM3bEh4ZG56R1RFVjBiY1NKMWFVd0hvMkVBMzNGYlRjV2ZIQVU4T3loc2NI?=
 =?utf-8?B?SldwMEw5OWRmMkFiWW1qSUtGdFJCU0UvR0lOMWVyZDBwN3czY3NKV0x5QjB0?=
 =?utf-8?B?cHhxSzVwWUFlbTFlTmt5ZHAzM2RsZTRuVmlqV1pGTTVHeWhDUVIyOEhRaW80?=
 =?utf-8?B?QXJMMzFJaml0Q0t1ZVJ5NG0vSGNXTTFZdHFZTzA1UUJUOGZmcHQ0U0tQWmo3?=
 =?utf-8?B?NTBjVFZTWkxmdzViMVNheFRuVWtIV2QrSjVBcVJtRjhaaVJ0akVENWcwWFhj?=
 =?utf-8?B?Q2VhRG9ycDl3endtajJ2bnZrdlZrUU9MMXp3N0xjcHB3aHIycEIwZVI1UUlR?=
 =?utf-8?Q?qLGSrb79IUwWD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YU1VSFJLazJxTW16b2NaYm44ai8rcWp1U1drb3MxQXdaRUVQa0l6NS9aVXhE?=
 =?utf-8?B?SnhDajlpV1VsUmR6dW9PbmdWUG9tUjBIb3AxTWtFMFdyS2VkYW83d0cvMHBT?=
 =?utf-8?B?bDFnMUxEaUkvdDlCS2NKSmNIdVVpUmJvVlBnOXE0U3NKMDVXL1ZoMFpDd2cr?=
 =?utf-8?B?UGJ2aThXdEhla0c1N09PZWl3OGRkL2lvT1ZXOTNzaTZuZFZvdUdhZm9CZWg1?=
 =?utf-8?B?NXhacC9QMzA0b1BjOHJURFcvK0JHWlN2NHpTb2VlMUVNZlZNbzBZSm4vSkRF?=
 =?utf-8?B?V05HMmkvQmlzSFFNRmVJK0xQN3RCN2JDWHJWOU1uTFhPUDl1Q3Nob2pHR0Vu?=
 =?utf-8?B?Wm1Fd0dKNFFrTFkxMG5ubGtQM1hUY3FWaUZ2eHFPR3hiNWpuMFVyUVoreHU2?=
 =?utf-8?B?eWh3cFRmaXZ0YzdPakZFSlp2VWNwYkRPNjlWbDExNWJ2b2tXUkFIblgzc0s3?=
 =?utf-8?B?dEtDWllpcjJjOW5xNExRM0VyNTRvOThVVzdVeGRpei9KeTVicEdMczFrUjhB?=
 =?utf-8?B?eitxcmI1UGNJTW02SndPR3AxaldVbkMrLzNoblpFcVg4QVpJTHo3cWcxc0dU?=
 =?utf-8?B?cE91ZnVWOGZVbFI5cER1ZWZzWXl0MEZHR2Y5NUQyeUZwaG94eUt0REovNkZh?=
 =?utf-8?B?L0Z2K3R1YlRqU0tCK1EwcHNBUE9HM2ZNWVBsUTNnNXJ4elFFWEV0ZkMvUlRD?=
 =?utf-8?B?Z1VVa2ZlZzdtYmkyNFJhZXBNTjZXdDdXK2xSejF3c1NURkRUT0pEOExTcUtR?=
 =?utf-8?B?MnYzNEpvVjh3SVFyYmRjUzZJNnZFcHRmdXVDM2RFNXJ1Y0xUY2FXOGVzY3hM?=
 =?utf-8?B?bEJIMzZpZ1hoNXNXVVVDbTV2b2RsR3JZL1hVbVFmZmFTNm1TaVNCQWpkWS93?=
 =?utf-8?B?SCtld1Z0RGYrNHpHUXgrUGVsZnRTUEZqbVJJOVRpandFUGNRZWJhcmtiYzh0?=
 =?utf-8?B?SnhNeXpjd0hEMnU3YnRiS2c4QnZaSmwxYm9YTzU5ZWlPMmJrUFYwLzV0K2JN?=
 =?utf-8?B?M3ZmcGxySERiZGFUUW5UM2hRL20vbUtIMDVWbUc3eXhkcG41bDB1SERvNUor?=
 =?utf-8?B?QkFVaDdtSnZvR1NncE5mcm1hc2RxMCtFbnoxd040SlNTbm41em9tOWp5N3RH?=
 =?utf-8?B?V0FNUzFZV2VsMFo0YVA1c0NsbTgyT29BeWZHUVlRc2lhd2ZsYUE2TVNuNm1E?=
 =?utf-8?B?YVhOU2oyMStUbXg0Q29rUm96dG5QczNldzlHMTR4T0hzcFVPTUprL1RXdis3?=
 =?utf-8?B?YmMvV044TTFlS2dkQWVEcFpPOUZnQ1R3Q3VWL1U4VzlPcGdNUzF0aVlSNGpm?=
 =?utf-8?B?Qm9qb1JBTHpSUWsrSjFjS042L1lRQ0tjZzFIbktCbHA4NmYrTXVZUVUza2JU?=
 =?utf-8?B?OStpNU9acHY3TFdQeUtBeFRiMzFjMnVtK2VLK1RpUzR4SnFpOEVRVTNsQnB2?=
 =?utf-8?B?cC92SnBkbUU5NUhEQWdFYmFqZzc2ZWdPOGJFZm5yRmNqRXpnYWlkNlMxaWNW?=
 =?utf-8?B?V2g5K0N4TmRWYzlic1ZRTDlKM3Z1MVdFKythZllEc3piRUQyMEhqSU5KTGhi?=
 =?utf-8?B?S3N0c2tsNlVTU3gzL0xock85Vi9FNkxyTzdBV3R5TWlzRmlHTFZqR2h6c09l?=
 =?utf-8?B?bEsyNjRLME9MUDhPN1F1a0pJOFM3OXZ5ZU1WTzBEQVpaa0c2UjJXK1F6UldL?=
 =?utf-8?B?a29PMEtzVHNRZWR4bitZWGxSOFJvZU9pTWIrVGEvaUQ1WWxkTHRnK2xVb0o0?=
 =?utf-8?B?WUtuVlRQODRjcm0wWGhTNXZZVHdGVlMxaHBwdlRHc3dTOXlqR2ZMTkJxQnVx?=
 =?utf-8?B?SlFrejlYa2VtMTgwelo0dVRIcjYxd2FFR21wRHp6MW5weE0rdW1XcVBNSHhF?=
 =?utf-8?B?U2lNMTVMcjROZEVSQ3ZSUnl3c0VMMmNVMXlYT2lwK0w5VVFjeWdWeDVWNmRZ?=
 =?utf-8?B?TFk0QWxEMExJYWxuN2l2MEY2dFZKMnlINFpPUURJNUdFZDRVNGZ5WUhqLy9M?=
 =?utf-8?B?Qk02cXc2TkFPOFczVG9TNXVZZTU4L0x5dWRvU3dpMFlMenNNRHlla1RzdURY?=
 =?utf-8?B?bW1BMDM1R1pya2dpWk5JUTVsMUhPb3BhV0RySGMrckVwbDZTaW9FeWM5dXdq?=
 =?utf-8?Q?23np0VwtdMeULKdO82BjgebuF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e183f8-fa31-422e-0440-08dd51a0bbdc
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 11:21:34.6216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1DOd0q3Y59xh56rUtdVwpJpv6RSLixCqwmGpRrs1SJ3yOMrjGUgHMhAuMQ87wbO7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8034



On 2/3/25 17:39, Michal Simek wrote:
> Hi,
> 
> Based on discussion done long time ago
> https://lore.kernel.org/all/5353872c-56a3-98f9-7f22-ec1f6c2ccdc8@linaro.org/
> it is better to deprecate firmware contants which are not used in any code
> and it's only purpose is to use macros in dt files.
> 
> There is no reason to be the part of dt bindings but it should be kept
> there with adding deprecated warning.
> 
> I want to see if this is the right way to go. If yes, I will also do the
> same changes in other headers which contain only constans which are not
> used in any code.
> 
> Thanks,
> Michal
> 
> 
> Michal Simek (2):
>    arm64: zynqmp: Use DT header for firmware constants
>    dt-bindings: xilinx: Deprecate header with firmware constants
> 
>   .../bindings/ata/ceva,ahci-1v84.yaml          |   4 +-
>   .../dma/xilinx/xlnx,zynqmp-dma-1.0.yaml       |   3 +-
>   .../bindings/iio/adc/xlnx,zynqmp-ams.yaml     |   3 +-
>   .../devicetree/bindings/net/cdns,macb.yaml    |   7 +-
>   .../bindings/spi/spi-zynqmp-qspi.yaml         |   3 +-
>   .../devicetree/bindings/usb/dwc3-xilinx.yaml  |   3 +-
>   arch/arm64/boot/dts/xilinx/xlnx-zynqmp-clk.h  | 126 ++++++++++++++++++
>   .../arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi |   2 +-
>   include/dt-bindings/clock/xlnx-zynqmp-clk.h   |   7 +
>   9 files changed, 142 insertions(+), 16 deletions(-)
>   create mode 100644 arch/arm64/boot/dts/xilinx/xlnx-zynqmp-clk.h
> 

Applied.
M

