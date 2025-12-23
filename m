Return-Path: <dmaengine+bounces-7910-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CA7CD9BC7
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 16:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 71E8F3021684
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 15:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B3328C2A1;
	Tue, 23 Dec 2025 15:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="LYnG3RpF"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010012.outbound.protection.outlook.com [52.101.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726DE2877D8;
	Tue, 23 Dec 2025 15:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766502526; cv=fail; b=qVSsAshIysQ4M7eKLUxkYCh/AuyUYLeVaIlnTFPVxqHCc3H/Z3FZ8Q3CebtTkmcnGpJTegVINy20PS1gxIcIkUdm20jRAY9r9xe2rBAe/hJr0v98dZnjzK3k2gblaY6bMSjPf9ebMW4rdvao7bN0hOJnMAUBkPgHCRYaGfAI/vs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766502526; c=relaxed/simple;
	bh=YJIlvF87c29HzGRiwuSzd1zuxEAwJkNq4b6AIO+I2SI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N7oAoRggPuBwoeYVyq68EuZ6B6GPWyn+XuAvvf1zJJ3srRSiPhQUM2nsyUcZV4Dr9EeB/BjdFMK5/8xR4AvKRvXDgCFxqLiCIBKfYdYWtmNhQJcrFQOOtbn7FX3tUe0gaPDkiE1slyR+Y940XcylmXosmCVSRYxwxsBTklwyGY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=LYnG3RpF; arc=fail smtp.client-ip=52.101.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ETTCXk2nNaowtSwZI6oxngyNPTM8jq52p620jyNBvcuDUfrs4dbV8EfacVuYhV48pja6nRhpyM74ENNDDmTzf64Vpn4KgGHgC++pDP8K2zSjxI5tYjiCkj6ydw0KMTK5QCDI6T6zFt1BWXQ4VES9rMx1Jcj/voWI2FbY5pyx0RVmErph2DmlQODELQQPHp/WPZsQefWScJcPD9lpwJ93Q2zrygzqknLPsHNu96QRamiyzpmI/aNI5ck8F3ciYvhYzcsuX0gviTJ1Herc+/9LLfs2kXy2fSuAcu6g44/vyVh0IxvbUaQXVGZc59Sb1URnP+5PdEvIzKNLnJ9H9+seqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YJIlvF87c29HzGRiwuSzd1zuxEAwJkNq4b6AIO+I2SI=;
 b=oF+Nq0TkHARegicfmm3A9MtGiHseNg/aBhF3FDPqBXIpbbQ4Y2ia+2JjERMD88bZbTVXQTgJLZpbnFm30/UnBDrrvPEyBm0/ygA8dKiCg9/cAJPIXUzFAG4vXFpGfWhMfGiAqvq/yNOmQ5xfvh9Ne8g4UM9bUFFzNDPERaQDOWfFE7XcEIRxPDsTdIskkxNX3+TcMMNf5GaFyunemo8mlZOt7w6vy0PSKLo5/u98K2T4AGhHW3Lb7sMUPOSrEiEDghyW9FaYKaeqgJUyjMsUo8o+CQb0tj8DlZReuWRaWvOrLbl6gZhlxzFDlfzfKKEys3Wy01bRLFjLxFHO9O/w1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJIlvF87c29HzGRiwuSzd1zuxEAwJkNq4b6AIO+I2SI=;
 b=LYnG3RpFUA1OhFQHj8Ep5/tTF7coGh5w7tKUddD3RN0XAfylD8R4kyvQK37fBEpl9haIv8XtugQ9fklVMv3yZJH0Fdmcf3VfFCezZOTt7m5Ew5vCeHeN+m92qdBKnkvShRMImrMuhZHihuVKyVx2wF6+9yInvo6QPau7OHVGF7Y=
Received: from TYYPR01MB13955.jpnprd01.prod.outlook.com (2603:1096:405:1a6::6)
 by TYYPR01MB7877.jpnprd01.prod.outlook.com (2603:1096:400:117::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Tue, 23 Dec
 2025 15:08:38 +0000
Received: from TYYPR01MB13955.jpnprd01.prod.outlook.com
 ([fe80::52be:7d7a:35ec:4b29]) by TYYPR01MB13955.jpnprd01.prod.outlook.com
 ([fe80::52be:7d7a:35ec:4b29%7]) with mapi id 15.20.9456.008; Tue, 23 Dec 2025
 15:08:38 +0000
From: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: geert <geert@linux-m68k.org>
CC: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	magnus.damm <magnus.damm@gmail.com>, Fabrizio Castro
	<fabrizio.castro.jz@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Johan Hovold <johan@kernel.org>,
	Biju Das <biju.das.jz@bp.renesas.com>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2 2/6] dmaengine: sh: rz_dmac: make register_dma_req()
 chip-specific
Thread-Topic: [PATCH v2 2/6] dmaengine: sh: rz_dmac: make register_dma_req()
 chip-specific
Thread-Index: AQHcYsEOwZapbRicGUK5mHW5izV50rUvXzmAgAAD87CAAAiqgIAABlag
Date: Tue, 23 Dec 2025 15:08:38 +0000
Message-ID:
 <TYYPR01MB13955534C5164A0176314EA9785B5A@TYYPR01MB13955.jpnprd01.prod.outlook.com>
References: <20251201124911.572395-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20251201124911.572395-3-cosmin-gabriel.tanislav.xa@renesas.com>
 <CAMuHMdV=EW4YbEBiXH2p0SeC5Kw-YmYWuQwsudpGgM63pgqcfw@mail.gmail.com>
 <TYYPR01MB1395515AF65F8522AED6B591885B5A@TYYPR01MB13955.jpnprd01.prod.outlook.com>
 <CAMuHMdU1+-o7AOjdJe7yCgU+4x3Kn6d8B5P-EWk6P5_qXsCOZg@mail.gmail.com>
In-Reply-To:
 <CAMuHMdU1+-o7AOjdJe7yCgU+4x3Kn6d8B5P-EWk6P5_qXsCOZg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB13955:EE_|TYYPR01MB7877:EE_
x-ms-office365-filtering-correlation-id: 548aafd0-0b33-4e3b-c02e-08de423526fb
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?UTBSWThaWCtrVWVBc0l6S2U3SUZLa2dwUm15UVdQSmFyem9reVN3cjJzZ0No?=
 =?utf-8?B?aGQ3UVFqRW53QXRjeC9rYytKaXRUSzFlWjdRc1RRcUdZRmNjK083ai92cExS?=
 =?utf-8?B?VWFMdzdPK0NDeE00Vko4SXh3YTRQM1hvcXpZUk05V3R4b0svUDRhdDVheTFh?=
 =?utf-8?B?UTUzaThvY1FuZzR6bTJ0WHZGU0c2RVVnTGhKaHM3WTlIdDBQOE81NXlDY2tP?=
 =?utf-8?B?WnArTW9UMSt1eEdGMXh6eXo3cEExbjZVNFZGd3dKbXFZQ2p5Y3NXb25zM2NL?=
 =?utf-8?B?SlUwcjFUaU5EUW1FWnNKQ2hFNk83WnRVQ1lzd3h3ZEhkRk1xSVg2TjBTcm9X?=
 =?utf-8?B?Y1VBWmNnTWZLUzVPUEtkUkJhSkE0VHdCbzh5a0E0L2RmekVwb1lFUmNRdlVV?=
 =?utf-8?B?cGlHVDBMRDkrVDIySm0zTW43Q1FTbVd6TnRWL3MyME9COUU4V1hTYTZvV0ov?=
 =?utf-8?B?VkE5U25lOGFHeTVEVGlOaTh1dVNrVjNuS3lFQkF6LzZFU2N1cnZibTBtRnFq?=
 =?utf-8?B?cnF4VDBWRGNDaE5uaFFtYS9iTlJvOERYSkErQkxEellseUpXK0JVR0FGei85?=
 =?utf-8?B?cm9vQ0dKYnpzQlNRZDlqRWptZ2twWDZ5RjlTb3RiYlNTU0tQQjJLZDUwL0dj?=
 =?utf-8?B?SkFOOTNlb0FseXV0MVg5UVIxR29mWkFvdFNkT3RiRnFSZTFXV2tOa3crajN4?=
 =?utf-8?B?dS9kYzJyWEZYVW82ZnVYNTdpV2J6MVU5UDRnQmZSeDFXRmM2WnlZSmFBdUFE?=
 =?utf-8?B?bVhrczJxRDZrWUljNStJRC9ZelZLaTRReThOTHhtcUJkbHVJZ2dXcGs1RzFQ?=
 =?utf-8?B?M1g1bmlpNTI3UG9UZ25FR2ltTURwKzMzc3I5Ym5NbFdYMVN6dzFjK0kzNUt5?=
 =?utf-8?B?bVdhYkZJMExWZytCMElWTnFNLzIvaEtYQ1BxVjV4WHVDVG00QVViSG9uYTBr?=
 =?utf-8?B?VXB4K2VycGI0M1MzOTlYUlQ4cTUra3pFcE45OHUyYTZnckV5YzlnZWxUaHpx?=
 =?utf-8?B?NHZ5WnRZRVRvMW0waGZZSmdIcE5KRGs3TTZPQmFTdkg4b3dFUWdsSDR4OEZE?=
 =?utf-8?B?SFd5QkY4ZFYreHlTVkpRUFRUK2llcGtwN1JCT1orMnRIRzBqSXc4QVZmcXpX?=
 =?utf-8?B?Tnd5TTRRQ1AyU0Y0WGZJRzFwSWNyZDBJeGN6Q2YxcVQ2UXl6OS9LZW1nQlYy?=
 =?utf-8?B?RmNOd014ZElWUDA3S2VLTy9zVnJQTlBidVRMaHMwQzJtVWF0Z1Q3dDFQdzVT?=
 =?utf-8?B?QlRCM1NxMmxEQVVtMXdlak1VQ1dteW9GL2NUT25QZExyckx4d2cvNktrNng2?=
 =?utf-8?B?bkZmQWMxR0grUjNDUDRyeGZ4MVpTNStST1NsbmZsajZhZnRkbVBMUDFETFBZ?=
 =?utf-8?B?eEVnVnNUYVdFamhYNVQ2VklaSDkvK21SNlhiNEg1Q1k1UGlyN3luNE5JVFdM?=
 =?utf-8?B?NndkWWZsMC9zWTZsM0F5WFdHaWNaV0ZRV0ZDT1Z5UmJ6Tnl2ckUrOGNzTjZR?=
 =?utf-8?B?R3RxRXFUTEM1UlhuZWt2cUFTS25SQ1A0b1M5YmtYMDBIK1VRMHlKUVJLZ05O?=
 =?utf-8?B?S0ZPTUN5ZVRMWk94a2lZQm9zcnVGSkovSnN2eGFyeU1teTc4WDZTQllkdm0v?=
 =?utf-8?B?Q1hzakZmYjY3TjlKK0NXbHdJU091dkRackQ2ekQ0eFpNbUtGWDRac1hjV0pl?=
 =?utf-8?B?ZG0wbWNDY1RMUVowRXN6b3JzeEdON09FK0psY0FKUmFBcVN0UGlRemdqamIx?=
 =?utf-8?B?Q1Z3NW5icWhsdEU2RGYvSU1XZU5iNkkySFVvdHRBVW5Ed0NIeDdXcTNTaTlR?=
 =?utf-8?B?TVdWV2IrbUc3a0pFTHpMVE5oaFdUWTdwZi8zU21oUXZKcDJ0d3U5TVAyTWxG?=
 =?utf-8?B?WlA5cEY2MGZWN05NaEtKUDR1WDlSb2tpWHQyY2o1Qzk2Vm9xcmlJbXIreWs4?=
 =?utf-8?B?RS9uWFYyRGk4M1g1TmZVR2VJbnNRZUQvNzUzNVg2ZjN5b2pkaitVNWZBWHJ4?=
 =?utf-8?B?dnlmdDdOZUpzeFdHcTdUMXl2WWdCd0g0OFRJUTAyRmNZSXB2ZWwwSk8zM2RT?=
 =?utf-8?Q?crPXin?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB13955.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NlN1dFppREV6dk5QcWFsd0V6a2ZQdjUybTNsK2gycEJQOURWRUhlcjA2RDdn?=
 =?utf-8?B?VmxsdkZaSVpKbDRIZm05NDJRU0FLdHB6bGl3T2VKYWErcTlQaE14c25WNzhX?=
 =?utf-8?B?cFF0dFZ2T2duV3plTFdNUzFtcHh4RUtIWDNISi9raGZZYzJLV3l4d2F1Ulc5?=
 =?utf-8?B?SXIyNDkrdjBMMThDRmVSeituSk4xYmNleG0wSnk2WTZQR2pBRm1zcnF2RXhS?=
 =?utf-8?B?ZkM3L3pjR25COVdUTnJSRGgvRFdpNUUrSFA1KzUvYk5YU1NWdkFFREpqckVy?=
 =?utf-8?B?Z2dKazFVK20wL3l1LzFaS21NKzVvdytxOFExeUVqa0ZXT3FCQ3lmRGtQejc0?=
 =?utf-8?B?ODRJeFVRYVNXV3c5QzRqenRWMXBHckxCYUl3TUNJckQ0NzlzOWtoV1JXdU5X?=
 =?utf-8?B?ZytGaDhEWXVRQzNKbWdhSnVtakFFSzR2WWhiUzRPNnFmQVZwUHZ0TC9EdE1V?=
 =?utf-8?B?ZUR2VEJPaU42SU80bDc5MVhzWU9Zd2Jic3hUaFdqaDNwRm9Rbm93QjZyOFo4?=
 =?utf-8?B?NDQ1Z0FROUwzUXptTWE5WTVYZlZhMm95TFRGU1BtRjBiZkJjb2k5Vk1mclZm?=
 =?utf-8?B?ZkNyVkhBeitmTkY0bVJwZTZLbDVqNEhSSkp0UWdWZ2FqV3BpYllqd3pnZ0tW?=
 =?utf-8?B?cTRYdnVuWGx2VkxNanlNRGVsZ216MTdMbHMwcStic3lnL1ZjRWhTSSthKzlp?=
 =?utf-8?B?S0lYOXJkaXB1VDdDZ0lTSUZpT1I0czZqbFM0ejE3b1NFa252ZHJ2RFhrVkZz?=
 =?utf-8?B?bGMzYUk1dTlzY2gzdXMvVElqdVJGeHk0T0Izc0hKV0xDb2VHQ3JuZXFma3Zq?=
 =?utf-8?B?cGh6L1VSUkc1THlxNW1NeEdDRzJPUFpubk5neStocXBhajdHQktjdVVVaFlr?=
 =?utf-8?B?TmJidTF5MmFwTW5wdkdQei8vL2lFeHlLMW9YY1VpUG0yTXRuQ1VCekFnb0ow?=
 =?utf-8?B?cytOaU14NVk5Z1REWElrNGE0cVo1dHNtdWFJRGozazVUaFlXeU44c3Awdjd1?=
 =?utf-8?B?WDFkdVB1MFlmSXc2eDNBRHc5TGxlamd2ZWU2dFdZeGtkK0xtSnlqV2Z4SlBp?=
 =?utf-8?B?dWNwb05xU0xYWUZXNnM4MmNWOTlxTE9hdXNtUGxHVDBvRDVyc0M1dHVBU2xI?=
 =?utf-8?B?ZmwzWGU5d3Y3NWEvWWVvOUlsVVZNU3JBSElxRkUzOEY1Y1ZRd3Q4MkZxS0pW?=
 =?utf-8?B?alZTWFRTYTFPWnhVTjV4OE9YalhDZFZDaE1FKzNHOGpWbS9SWEVBUDI2KytR?=
 =?utf-8?B?ZHNRUVpHekZLWElmQmsrSEZtZG93VHZkRCtIdmM3ekx6M0ptWm4wTG04bGZN?=
 =?utf-8?B?N2N3dXZyM2xIeDR5b2p3Z0Z1VGdkUXYyanlxOUY4bUFMZWpBTnhxMEsyTWtz?=
 =?utf-8?B?WmpxbVQxV00xQ09uWmNSZnNacUdudVNzRXMvdzV2bW0yakhTaE92YW03QWs4?=
 =?utf-8?B?VmNNSEExUkVQMWVVcW54TmpxRlpDOW93UWJDTmpkMkp5SzNwL3h4ZGs2T0Jq?=
 =?utf-8?B?bHNWN3Btb2lMSFpYcktPU0RLVExKZGVtWWIyYkRvQ1NmTG9DVjRUTnFyemR6?=
 =?utf-8?B?bjlISytTSFg1Wmk1TjFkRHVTRVZFdWJEdXU1d0hJNlVqTVNPRGJNcWRWc1Nm?=
 =?utf-8?B?WVQ5VWVOa0pOYlpPSFFmbjJZQmUvbE55NlpHVjRYT05PVTVUTDRLTEJ0SndP?=
 =?utf-8?B?L3V3RmlybW9uTmN2VWtLVXhtRklEbWxHL2R2WEtDV0JKMXJadDVDbUxvOXRk?=
 =?utf-8?B?UzM5UUZuS3NJNlgwYk1TTEZUcmR6THhwbnZEODQxTnVUZlg3N292N1dhQTN4?=
 =?utf-8?B?Snc0SU5ZOElIUFQwMVhWUDhCbmJEbThrbFJjTTQrZTA0Si8yc2t4bzFvQTR5?=
 =?utf-8?B?Mm1NQW9LbDByQUtsMDJzQXZpQjBPS20xYjlvNTJ3RWY0cXJnUjRGSEdUdFB4?=
 =?utf-8?B?ODN2d2JCRFlXeHFUT0RHdXprS0JhN2VGYnVxaVNRdUhMS0pLeHRBb201bkx4?=
 =?utf-8?B?RXFHdG5xUjFQQnczdFZ1V0RYekxCOTBBY1hWMEN3cEl4Q2VYU2hKN3M5QkFR?=
 =?utf-8?B?MkZYZjNmdC9DRDBLWmtKeU9iOWtML3VSaXZJbW9MNlY2bjQwNTh1VXRjYzBz?=
 =?utf-8?B?V1MwRWJlUVhhOTR5bGxyMTJTVmZvaTlvVEtwQjdFRnRacjJldVFBUk1WZWJJ?=
 =?utf-8?B?eklJNmZ2dVZWZklHRGdaZHQvcWRMdHBrZnJEUHVHUUtvMlBGMmpUbitTODRn?=
 =?utf-8?B?NzczemFtMmFYMnJQbUZEUmZVZFJPUXlLTUhIdEpqeVZzNjk2MTIyUmdJempL?=
 =?utf-8?B?dUU2ZVdjRnB4WHVoM05GSW9KNHZNMTJSZ0JjUnhLbXd0VklTSnhnZW5hVVUx?=
 =?utf-8?Q?6pCc2GTEJB+D70L4me2f+Fkr8ikU2A2SBOtHU?=
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
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB13955.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 548aafd0-0b33-4e3b-c02e-08de423526fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2025 15:08:38.7882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8anNlWCLuJ+IHSZIkEBPxcMKAkvbi76ks3gPbOTR4L9iIT8YOSHvq9v4L8Y7mYWGi5qry9AiQGqKsAoV8+b64DCDIc7e1BSaWYUFAGg6NTEM/qdXrTb+JGiTbvG85HVO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB7877

PiBGcm9tOiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02OGsub3JnPg0KPiBTZW50
OiBUdWVzZGF5LCBEZWNlbWJlciAyMywgMjAyNSA0OjMwIFBNDQo+IA0KPiBIaSBDb3NtaW4sDQo+
IA0KPiBPbiBUdWUsIDIzIERlYyAyMDI1IGF0IDE1OjA4LCBDb3NtaW4tR2FicmllbCBUYW5pc2xh
dg0KPiA8Y29zbWluLWdhYnJpZWwudGFuaXNsYXYueGFAcmVuZXNhcy5jb20+IHdyb3RlOg0KPiA+
ID4gRnJvbTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4NCj4gPiA+
IE9uIE1vbiwgMSBEZWMgMjAyNSBhdCAxMzo1MiwgQ29zbWluIFRhbmlzbGF2DQo+ID4gPiA8Y29z
bWluLWdhYnJpZWwudGFuaXNsYXYueGFAcmVuZXNhcy5jb20+IHdyb3RlOg0KPiA+ID4gPiBUaGUg
UmVuZXNhcyBSWi9UMkggKFI5QTA5RzA3NykgYW5kIFJaL04ySCAoUjlBMDlHMDg3KSBTb0NzIHVz
ZSBhDQo+ID4gPiA+IGNvbXBsZXRlbHkgZGlmZmVyZW50IElDVSB1bml0IGNvbXBhcmVkIHRvIFJa
L1YySCwgd2hpY2ggcmVxdWlyZXMgYQ0KPiA+ID4gPiBzZXBhcmF0ZSBpbXBsZW1lbnRhdGlvbi4N
Cj4gPiA+ID4NCj4gPiA+ID4gVG8gcHJlcGFyZSBmb3IgYWRkaW5nIHN1cHBvcnQgZm9yIHRoZXNl
IFNvQ3MsIGFkZCBhIGNoaXAtc3BlY2lmaWMNCj4gPiA+ID4gc3RydWN0dXJlIGFuZCBwdXQgYSBw
b2ludGVyIHRvIHRoZSByenYyaF9pY3VfcmVnaXN0ZXJfZG1hX3JlcSgpIGZ1bmN0aW9uDQo+ID4g
PiA+IGluIHRoZSAucmVnaXN0ZXJfZG1hX3JlcSBmaWVsZCBvZiB0aGUgY2hpcC1zcGVjaWZpYyBz
dHJ1Y3R1cmUgdG8gYWxsb3cNCj4gPiA+ID4gZm9yIG90aGVyIGltcGxlbWVudGF0aW9ucy4gRG8g
dGhlIHNhbWUgZm9yIHRoZSBkZWZhdWx0IHJlcXVlc3QgdmFsdWUsDQo+ID4gPiA+IFJaVjJIX0lD
VV9ETUFDX1JFUV9OT19ERUZBVUxULg0KPiA+ID4gPg0KPiA+ID4gPiBXaGlsZSBhdCBpdCwgZmFj
dG9yIG91dCB0aGUgbG9naWMgdGhhdCBjYWxscyAucmVnaXN0ZXJfZG1hX3JlcSgpIG9yDQo+ID4g
PiA+IHJ6X2RtYWNfc2V0X2RtYXJzX3JlZ2lzdGVyKCkgaW50byBhIHNlcGFyYXRlIGZ1bmN0aW9u
IHRvIHJlbW92ZSBzb21lDQo+ID4gPiA+IGNvZGUgZHVwbGljYXRpb24uIFNpbmNlIHRoZSBkZWZh
dWx0IHZhbHVlcyBhcmUgZGlmZmVyZW50IGJldHdlZW4gdGhlDQo+ID4gPiA+IHR3bywgdXNlIC0x
IGZvciBkZXNpZ25hdGluZyB0aGF0IHRoZSBkZWZhdWx0IHZhbHVlIHNob3VsZCBiZSB1c2VkLg0K
PiA+ID4gPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBDb3NtaW4gVGFuaXNsYXYgPGNvc21pbi1n
YWJyaWVsLnRhbmlzbGF2LnhhQHJlbmVzYXMuY29tPg0KPiANCj4gPiA+ID4gQEAgLTEwNjcsOSAr
MTA2OCwxOCBAQCBzdGF0aWMgdm9pZCByel9kbWFjX3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2KQ0KPiA+ID4gPiAgICAgICAgIHBtX3J1bnRpbWVfZGlzYWJsZSgmcGRldi0+ZGV2
KTsNCj4gPiA+ID4gIH0NCj4gPiA+ID4NCj4gPiA+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgcnpf
ZG1hY19pbmZvIHJ6X2RtYWNfdjJoX2luZm8gPSB7DQo+ID4gPiA+ICsgICAgICAgLnJlZ2lzdGVy
X2RtYV9yZXEgPSByenYyaF9pY3VfcmVnaXN0ZXJfZG1hX3JlcSwNCj4gPiA+ID4gKyAgICAgICAu
ZG1hX3JlcV9ub19kZWZhdWx0ID0gUlpWMkhfSUNVX0RNQUNfUkVRX05PX0RFRkFVTFQsDQo+ID4g
Pg0KPiA+ID4gU2luY2UgdGhpcyBpcyB0aGUgb25seSByZW1haW5pbmcgdXNlciBvZiBSWlYySF9J
Q1VfRE1BQ19SRVFfTk9fREVGQVVMVCwNCj4gPiA+IGFuZCB0aGlzIHN0cnVjdHVyZSBkb2VzIHNw
ZWNpZnkgaGFyZHdhcmUsIHBlcmhhcHMganVzdCBoYXJkY29kZSAweDNmZj8NCj4gPg0KPiA+IElu
IG15IG9waW5pb24gd2Ugc2hvdWxkIGxldCB0aGUgbWFjcm8gbGl2ZSBpbiB0aGUgSUNVIGhlYWRl
ciBhcyB0aGUNCj4gPiB2YWx1ZSBpcyBtb3JlIHRpZWQgdG8gdGhlIElDVSBibG9jayB0aGFuIHRv
IHRoZSBETUFDIGJsb2NrLCBldmVuIGlmDQo+ID4gdGhlIERNQUMgZHJpdmVyIGlzIHRoZSBvbmx5
IGFjdHVhbCB1c2VyLiBCdXQgaWYgeW91IHRoaW5rIHRoaXMgaXMNCj4gPiB3b3J0aCBjaGFuZ2lu
ZywgSSB3aWxsIGNoYW5nZSBpdC4NCj4gDQo+IEkgaGF2ZSBubyBzdHJvbmcgZmVlbGluZ3MgYWJv
dXQgdGhpcy4NCj4gDQo+IElmIGl0IGlzIHJlYWxseSBtb3JlIG9mIGFuIGludGVybmFsIElDVSB0
aGluZ3ksIGFuIGFsdGVybmF0aXZlIHdvdWxkDQo+IGJlIHRvIHJlbW92ZSBhbGwgcHVibGljICpf
SUNVX0RNQUNfUkVRX05PX0RFRkFVTFQgZGVmaW5pdGlvbnMsIGFuZA0KPiBqdXN0IHBhc3MgLTEu
ICBUaGVuIHRoZSBJQ1UgZHJpdmVycyBiZWNvbWUgcmVzcG9uc2libGUgZm9yIGZpbGxpbmcgaW4N
Cj4gdGhlIGFwcHJvcHJpYXRlIGRlZmF1bHQgdmFsdWUuDQo+IA0KDQpNYXliZSBpdCBpcyB3b3J0
aCBrZWVwaW5nIGl0IGxpa2UgaXQgaXMgZm9yIG5vdywgYXMgVjJIIElDVSBpcyBhbHJlYWR5DQpt
YWlubGluZSBhbmQgVDJIIElDVSBpcyBhbHJlYWR5IGluIG5leHQgd2l0aCB0aGUgc2FtZSBBUEkg
YXMgVjJILg0KDQpJIHdpbGwgc3VibWl0IGEgc2VwYXJhdGUgc2VyaWVzIHRvIG1pbmltaXplIHRo
ZSBwdWJsaWMgQVBJIG9mIHRoZSBJQ1VzLA0KaWYgdGhhdCdzIGZpbmUuDQoNCj4gPiA+ID4gK307
DQo+ID4gPiA+ICsNCj4gPiA+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgcnpfZG1hY19pbmZvIHJ6
X2RtYWNfY29tbW9uX2luZm8gPSB7DQo+ID4gPg0KPiA+ID4gcnpfZG1hY19jbGFzc2ljX2luZm8s
IGFzIHRoaXMgaXMgbm90IHJlYWxseSBjb21tb24gdG8gYWxsIHZhcmlhbnRzPw0KPiA+ID4gSSBh
bSBvcGVuIGZvciBhIGRpZmZlcmVudCBuYW1lIDstKQ0KPiA+DQo+ID4gcnpfZG1hY19nZW5lcmlj
X2luZm8/IEkgZG9uJ3QgaGF2ZSBhIHN0cm9uZyBvcGluaW9uLCBidXQgSSBhZ3JlZSB0aGF0DQo+
ID4gY29tbW9uIGRlbm90ZXMgdGhhdCBpdCB3b3VsZCBiZSBzaGFyZWQgYWNyb3NzIGFsbCB2YXJp
YW50cywgd2hpY2ggaXMNCj4gPiBub3QgdGhlIGNhc2UuDQo+IA0KPiBGaW5lIGZvciBtZSwgdG9v
Lg0KPiANCj4gR3J7b2V0amUsZWV0aW5nfXMsDQo+IA0KPiAgICAgICAgICAgICAgICAgICAgICAg
ICBHZWVydA0KPiANCj4gLS0NCj4gR2VlcnQgVXl0dGVyaG9ldmVuIC0tIFRoZXJlJ3MgbG90cyBv
ZiBMaW51eCBiZXlvbmQgaWEzMiAtLSBnZWVydEBsaW51eC1tNjhrLm9yZw0KPiANCj4gSW4gcGVy
c29uYWwgY29udmVyc2F0aW9ucyB3aXRoIHRlY2huaWNhbCBwZW9wbGUsIEkgY2FsbCBteXNlbGYg
YSBoYWNrZXIuIEJ1dA0KPiB3aGVuIEknbSB0YWxraW5nIHRvIGpvdXJuYWxpc3RzIEkganVzdCBz
YXkgInByb2dyYW1tZXIiIG9yIHNvbWV0aGluZyBsaWtlIHRoYXQuDQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgLS0gTGludXMgVG9ydmFsZHMNCg==

