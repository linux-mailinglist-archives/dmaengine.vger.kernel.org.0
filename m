Return-Path: <dmaengine+bounces-8758-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNuPJoObhGmh3gMAu9opvQ
	(envelope-from <dmaengine+bounces-8758-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 05 Feb 2026 14:30:43 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F47F3448
	for <lists+dmaengine@lfdr.de>; Thu, 05 Feb 2026 14:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A789A300CE43
	for <lists+dmaengine@lfdr.de>; Thu,  5 Feb 2026 13:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8765312D21B;
	Thu,  5 Feb 2026 13:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="VTWYWV05"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010031.outbound.protection.outlook.com [52.101.229.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC70E42049;
	Thu,  5 Feb 2026 13:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770298237; cv=fail; b=Qs3VnUq/qTsCAZfUgEoDxS9pZ3CDakX6Tqe6oR0GQu3ePYL7ruoDCeFbl4/IcB+EXGxZSfs1+t+2teD/MAEoKhdk8agISlyT91OJQRSC/Gk/9MJCYFlBZ1l660Ufu3HgHpzLfuoC6qi4egIrWZBqlNVMKdxZzoN0xOX4gK8pGfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770298237; c=relaxed/simple;
	bh=XLBWdUhbvu0U68LmKA/Xwc3NTrB+Aoyn9rLXCQSgwPo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p5L/GPsQJGWf26gAyjzhkGK96bYayTSGFp8kSvs/ys+OFKE+G0d9136ARM9rCBOyj+1wESi9dfZERGn/isArSMhQHTb455GQJzjz2jYWm893xsKdgvD2EOkBQ/N6q9afEfdSh1IFTGNbBOts1oMNVQzyrX5ZW4g1rNmKg4nbUa8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=VTWYWV05; arc=fail smtp.client-ip=52.101.229.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vWyLJ6+xKyDmPODpTMq+zpqm7iD8Ld1wjPAKOLc/o9DcURZXKwHQV/W57L+9voW6LaId845TYcz/3L7FeB4Vdv7B4uSlMwQPA0qumB9TIJrWdUT/7McPjR/9e85NCp4wD+ib1BRH/dvbDKUq08xgRpUFhQ4zH/Fj5UKY3dnrL3Mq98+3WC8e0371lfX7BnDmr3d6s+moFmMzFNMwLKjyssFZ/k5v6DD0g1SwHoWHtcD80AL6PcB45cBwjGFTDYJGWkjRcZFlvZyhk83O9h7tPerglphczsjM9DLlhOU4geW3/TA/uOnojPd66FCKLaskLHE+MfO7IdAvoHdYKH7cGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLBWdUhbvu0U68LmKA/Xwc3NTrB+Aoyn9rLXCQSgwPo=;
 b=g5hSYfVAv5FABBsGDclLRBr0FQuoHxtxP+5aSFamJJaeYy8ILQSeEApVBtLsuT8xKi+PWOY3kAPJOPje8GzPLlQAplAWYEgv8gCBraQEPRU8MdnGp4PqDZlHpzjyFthPRQrY05V2+uHBChFACmFkVRpxu0ewdv3MxBwIzFoLkd9H/CKW+SK47ievEKE9G7Gx/17Ur3trdmffO37SGWclva7MVzvJmdVioA1HpK+DTIc0bs+X5gavTV1uPOj7JjMlESk2uKYm9hpfl4SfWGO8nOkbp/vP+GVQABbiKNqaGmJu6RuhHqu4wv66T3V0LHcSeoxgH+AFGTCzC3yKYnZFHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLBWdUhbvu0U68LmKA/Xwc3NTrB+Aoyn9rLXCQSgwPo=;
 b=VTWYWV057iX1eecbTYTMi73TXvl8wYexKKNLElIKgQCXFGRju50vZt0GAt3OycMQAlLvwjf5w7n2CWvcyMtEP9H2B3Uen3713TlA430Ap/6lhlAmUBFiqDXTcUfI1si0lQBWokTBVrrqpF5Su+OL4PC10Psu3euwkk2ZgW+/baY=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY3PR01MB11189.jpnprd01.prod.outlook.com (2603:1096:400:3d2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 13:30:32 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 13:30:32 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu.Beznea <claudiu.beznea@tuxon.dev>, "vkoul@kernel.org"
	<vkoul@kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, "lgirdwood@gmail.com"
	<lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>,
	"perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "geert+renesas@glider.be"
	<geert+renesas@glider.be>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>
CC: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH 5/7] dmaengine: sh: rz-dmac: Add suspend to RAM support
Thread-Topic: [PATCH 5/7] dmaengine: sh: rz-dmac: Add suspend to RAM support
Thread-Index:
 AQHcjq8LxgsLnLJrc0+4TWo3c3gckrVkQ4/QgAAW+wCAAAEtcIAACGyAgAAC1MCAAAUUgIAAAEvggAAlpwCAD49ggIAAByHg
Date: Thu, 5 Feb 2026 13:30:32 +0000
Message-ID:
 <TY3PR01MB11346321A9AAE93C7070C6E578699A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260126103155.2644586-1-claudiu.beznea.uj@bp.renesas.com>
 <20260126103155.2644586-6-claudiu.beznea.uj@bp.renesas.com>
 <TY3PR01MB113461F734BA087B60605C6FC8693A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <16a6f14a-93e6-472c-8718-d46972f0ac5e@tuxon.dev>
 <TY3PR01MB113463BE8A4B1A40DBB0860538693A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <5438ccc8-ed5a-4dd6-8995-e8e9926883a5@tuxon.dev>
 <TY3PR01MB11346325F46C2BCA6B2B181D08693A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <ad752abc-275b-43ca-aec3-188c1a69c50b@tuxon.dev>
 <TY3PR01MB113460006A458AB2F8B96542C8693A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <TY3PR01MB11346C8AD27554E40EC5746E38693A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <7f0305f6-ae2d-4069-b53a-d2a81e75d164@tuxon.dev>
In-Reply-To: <7f0305f6-ae2d-4069-b53a-d2a81e75d164@tuxon.dev>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY3PR01MB11189:EE_
x-ms-office365-filtering-correlation-id: a1589d56-efca-4676-d38c-08de64babce1
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?YW1QVmg0UjBWUEYvVno3OVN3L1EyNVhNNWNXRWdTU2xFckNrT092VjJhb0Ez?=
 =?utf-8?B?NzZEdm5Ibkp3WVhyVHZxejFLY1ZwdUZsbGd0Z2Q1OUxreGJNODJFZEtJN0gy?=
 =?utf-8?B?TEdjbDQxcWVBT1FNUzdBV0dUWkd6aW1pNjcvcnMvL05SbTNJMWh3TnZWcmZH?=
 =?utf-8?B?RmhsazMwbEFaSXdNNVl0aklwSHMzVzZGQ1hXL0FnUmtqYWpQUHVqdllhUWdh?=
 =?utf-8?B?dVpVOWt3SHNueklpT3hzK1c2TiszUFprdy9MR0lZWGpvUnR5RG1FT21YR25k?=
 =?utf-8?B?eW5MS3RJZXdzSHlCamJnVldOZHBwRng3Q0FvRTJtK3Q1VEpETXVYeXpKUERx?=
 =?utf-8?B?ZTZEVnJVQlBBeFU3ZTF6aEFoY0RNUmY0MUw1bUkwdDFVVEs1YXY1R3pLNkV5?=
 =?utf-8?B?YURERWFhQ05yVkJSUmtmd0V3U3RRenAvKytIazdMWDNuVlJDQ3ArMllCWS9z?=
 =?utf-8?B?MWRiU1dBbnNaTWptVDFyRW5tNndadTdnNy9Ha09WKy9UZjd6dXlLY0Y5eHpX?=
 =?utf-8?B?YUdSYlZGTmxCcS9LUlZEaS9CZHFsKzR1YzFXVWYreUxFR295M09SbE5sb21O?=
 =?utf-8?B?RTQzWkg1dllrNG9DQWFBOFNra2xZRU90OFVOSDlNdGFBMlhwa0lHQ1pkcWdx?=
 =?utf-8?B?U3hBRUVOa2l1TUh2b3hFNmtoaHYvNms5dVMybTJMcGxPY3RXekJmaFA0Q3Fy?=
 =?utf-8?B?M3JwTnlFdzRZQk5uM200d01NblJld0tSOEg0WnpxeUsyRVhzZGJ3U0lPbTVj?=
 =?utf-8?B?Zmk4ZVBsQ2dROVpDQ2NJNmpoS01oOEQ0TTd6ckkvWjNXZ1lJUFl2eE1qZTdi?=
 =?utf-8?B?UDBRejdlbUF6QUJjN2R0R084Q2pVZDB2dE9sd09UNUw0Tk9oNHVVY2lHd3FB?=
 =?utf-8?B?ZFdIb1dsQnJxS0lhd0FtU3dLYjBkWXhybnZ4TzJQT2dMeGV4ZDdKYnNMMlRH?=
 =?utf-8?B?alIxZThROGgxKytmQ09Pc0hJMWRPZUlEcFp2cHlNTDJwVHdxbW5LZUZHVzht?=
 =?utf-8?B?aldvOThnUlRwbkFaTmMybFppREE1N0hnYTgzdjFBK25MQWg2LzBZcDlnWGZZ?=
 =?utf-8?B?S3pWT1dpVkpwOTFWRURHWmhBYk5RT2RpcFhhTFZRVTArMU00ZFJGZFF5QVZO?=
 =?utf-8?B?eFV0STV6YlNReDgreEZSUVVjSVorSmVJMytKK3VtSk9ZQmpXWVBpUy9HR1Nl?=
 =?utf-8?B?Zy9nbUZsQnlsOVl2bU4vbUMvZGtNQkNnVU44b2R1ajJPUXBWaUQrQW1OY0tY?=
 =?utf-8?B?VjMzMWpDNVlTV0ZxdjlzeHpEdWRGZ0IxL0pXTlJWSnJRWGxVRWN0QlFLbXov?=
 =?utf-8?B?QVdzSTZyTnAxODRWQUJ3OU9Vd0JZdC8xWkVIdXcvdDV0eWVWTHZhQWUrRE1O?=
 =?utf-8?B?T2R0ZjhxNnVnMnZ3VUZ3Vmp6alpRcEV2RnlCTndvdGZHVnJTUWpjakpoRjFj?=
 =?utf-8?B?d1JaMzdBS3IraTV5dG50cWNneFRmY3hKdUc2NGdOdnQzNDFlME1Ka1JBQVND?=
 =?utf-8?B?RDFYbUxXUU9NMWNLSGpQaXovbnlOQVcyU0ZDZkxkQzRoUXN2V0NDMG9ma29R?=
 =?utf-8?B?cnY0L1VrZUJtclpIQnpUUmYrTUhuVWl0OU10NXBVcEk5RXlVTUE0SzZOeU1H?=
 =?utf-8?B?WWJZVWYzZTB6RmZsMExnbmFQNVpGa3c4NGxWUUtXRHNaek10WVZUQnZvVkNr?=
 =?utf-8?B?MElhcXhBMXBFbndNY2lqTkI3TWRoVWxnV25wSUZsdGNJeVVvQWFnTWZuL0xG?=
 =?utf-8?B?bGFMcHF2Y0ZQbWNFbXltRHI3RFp2VEkwdlRScExtNzBQWkNvS01PdGtvTmcy?=
 =?utf-8?B?c2lYK2ZGVnF3WUJSK2IydmRlSUVrUytpQlFrWFlyalg3dkswbDdUdnFGMEVK?=
 =?utf-8?B?eDJiNmZsKzJhdTNLRlJZK0h0ek1ja0x2d1krdG5ud3RjSmZzUmRLek12TTZy?=
 =?utf-8?B?Qkw3YXBhcUt6eVVzZnovVkFlVFJBNElMMzl6VTZZL0ZjOWV2SFk3aE1hcmpy?=
 =?utf-8?B?VmVLSWRkdGVvVVpYU2tYdjg1KzhaNG5sVkt2NjdTN3JNNFNhSUhTcU9EcFJr?=
 =?utf-8?B?ZElPb1FsdCtWSG9CZ2dsREN4V1pzNlVUVmUzTHoxbHN5VTJ0eW1yNFBvU1NY?=
 =?utf-8?B?RERrVDc3VVROS3NMdHRYanNkdEsrWkxHT1VkSmtNakRsNEx0eFA5YkxjelBB?=
 =?utf-8?Q?jg8ZsULIzrgYcbucbmLEnmWOP88KUgpUis3kU7xglxBL?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Zmhaa2NUSVhXcUI4MWphSzFXbzQwZUU2bTJlcUVYZWcrVHBObHFYTEFKL2Fo?=
 =?utf-8?B?VHpRSHpESk0weThkSTViUWNlK3k4dVJxdmFkUHY1TVVhdWZqb3REeXhxZlRU?=
 =?utf-8?B?aGpGZDhYSjhuZXAwV096QnpLOVY3WWV6V1JhVmluTVJ1M3FsZlJibVRCQkRK?=
 =?utf-8?B?ckVkNUx0Wkh2SWhZUmNPQTV2a1ZEQi9mV1JTSnluOFJLYU81VVNEYVc2QUZy?=
 =?utf-8?B?Z05CTUpUcmZCWE5hb21KMG9oRWdxVUJibTQvU3VZV0czb2JqS1dJTnlvYXcv?=
 =?utf-8?B?enZmenNGK1VxQmhQTXcvdmVid3NIV3FoVDZueklGR3hUcUNPZjhpancxbzRQ?=
 =?utf-8?B?Skg0WHhuWjRZblorZGJZQUYvdXlVWDI5T1Q3WVpJVzZnYmx4akZOTjdIMlZr?=
 =?utf-8?B?TlRYcTlIRFdHUEFic1FGRnQwM0lDc1lJTmtvV1NZOC9oSW54cTRQKzc4cUdP?=
 =?utf-8?B?RzF5cE04MW9hMzNmNU1yaXo3NXVMUjVrQ0VBWkttQUxNRnBxOXVlL2h2K1lr?=
 =?utf-8?B?QndTeENJdUdlSy9rSTBmY3liZk85a1NNM043aTVxSHM0ODd1V3JPYTZkYjJ5?=
 =?utf-8?B?VDFvQ2U0b01RYWVhZU8xcVMxbEtoRXkzS3J6Ym9RbjlVNnVDMGtYTTVPSzhv?=
 =?utf-8?B?R1pFTE13TDJFZ2crVzZmMEdRNW4weWl4VlNweUNxa05tZFN3UnFBdTg2b2lR?=
 =?utf-8?B?U29qbkM0aS9OeHNISWt5cDNmZ0ljenpoNTlkdWhSRXFaSTRwRTRIbnFrOFlk?=
 =?utf-8?B?YjY2S2xPZ3htWWFGbFY4eUFVektpTlBZb3Rpam9FanFjUlZVSUtsL3VpNGlK?=
 =?utf-8?B?UFZiNU9RMXQrMGJSODJEcWpKVEM0V2NEcUJ3ekthWGVtZmR5MXBhdnVPS2xl?=
 =?utf-8?B?QkNRZVROWUdzQUtMWGppbjk3K0tETDdBa2x6VXhORmV2Z010UWs3SGR1TU1X?=
 =?utf-8?B?YzdzVllIRWZNQXpKNk1jYUR0UlJnR09Ua0piWHFDQUtsUWc2T3EvTVFDeVYw?=
 =?utf-8?B?TFBlV090TGE4eXMraWdqbDhFaDI2MjRDejFmaDNBUFczSkpBWHlaQjd2TjNC?=
 =?utf-8?B?ME5IWVNwNkxmMXpnZFJDTTBYSy9JY0Fjbks2NWhKckQ3Ty9pZjJrUSthVm9S?=
 =?utf-8?B?d3dNWG1GbW1xYXZiNlh2cjhhRDNZclkyZWxsWUpQVVc1QnovTVg4aXdnVWpq?=
 =?utf-8?B?Z3U4U0x3T2NseWhUY0ducW52T25WTWFWRHVnc2pZWDUvZ09xZmRhNDVCbzY2?=
 =?utf-8?B?cXdLQ2pnV1NkN29sT1ZVMWQ3aXU4S000bUlFNUM4VXhTQkYyUUwyWjZmMGs1?=
 =?utf-8?B?d1BMUjgzQnNDY3JoQUxxUlk0emFmNnUwN1JsaS9mYzk5U3ZrZ0REMzJrY3h0?=
 =?utf-8?B?KzhlYVIxT0xWQWVWVWxmZVluMmRkVEF6V3NDT0tiMzhzTHJ6RDFNTDVzZGpF?=
 =?utf-8?B?WWU2enFvQU15YlpJYjRQN0h0Ym1LWmc5WVJaSGphUFgvTEMyMkhwZy9ReTRW?=
 =?utf-8?B?Szg4eEtJYzlJTHBFS1V2Vk5lM3BreUJORnlOSkJMeVBhcGpaOTR1QmNIU05n?=
 =?utf-8?B?em9SVDJlKzdnSDFmSVQ3aWZQeGQ3ei9VTWhLSmFXSW9vQXpBbGtqTGUrWW5u?=
 =?utf-8?B?enRLaDZyaURoOVRCazQzb1k5STBscC9QS3ZncW5DRFl0ZjN2YzZKYTNvTEsy?=
 =?utf-8?B?M1ZjenZwa04rbHVyUnhEUGNhbnlzRWlyK29DSFIrYk83RlVHZ2hiVG5IcVpM?=
 =?utf-8?B?dXI3WXNEZlB5ckIwcHNjVXhoNUNsN0lmNXNEOGtwbDJ5VndQTnViQzllUzgv?=
 =?utf-8?B?UitLZVphSEFtRXo4OHFPUWJCRWQxd3czNjdsODhyQ29NblFIRTVwTXd4ZkFJ?=
 =?utf-8?B?TEhOb09ES2xucGJGOE56cXZxekhiZ0xmZEo0VFNsczNJMHRMK1hmZWZrOFlq?=
 =?utf-8?B?UHhQcmRvVktrU04vS3FJV0x0NkVjd0ZrUDRFOW9TcndsQVRxK0k4d1hUNk1E?=
 =?utf-8?B?NjJUQnFtMnpWNFpaQVRVcnlXbW5WKzJrT1FiMHRlNDJ3NFkvUHdUcVhMTGtJ?=
 =?utf-8?B?cGR3VVJVYnA0c2xPM3Y0ZHRTM0JpbXdHSFVpdnhHSHVCb1VzYU8xbDJ3eGJz?=
 =?utf-8?B?aldXb0pXMDRxMCtyQ3puUjdTb1RjcHhFZzgxZjl2cUpxeEV5RVhkdGxRZUtI?=
 =?utf-8?B?bnhLQkw4RjFxSGlrbHorc1dqUWpkUzRuYmhEa01aenNZMCtvZXJhTzhXK0lK?=
 =?utf-8?B?d0ZHVnhmYmEyUGg5WkljcW4wTDhxTkN2NjdUeDB4aFpXRlE0bGF2eXhBd0RL?=
 =?utf-8?B?T2JDWGI4SmkrWkN4WGo3QjhoLzNXc1dSckJpRExWcFExWGdjRVhnZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1589d56-efca-4676-d38c-08de64babce1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2026 13:30:32.8217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cyzSChQPmlGm/s0uYDP9LLsYk0AT5qBEuetLhGB7q1cz4gz0VNN5EiaMf2DuweF4bLuo0MooQyhB2wc6C0iQ8mx1w+J/9mMGaO8ciYuR1xg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11189
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-8758-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[tuxon.dev,kernel.org,bp.renesas.com,gmail.com,perex.cz,suse.com,pengutronix.de,glider.be,renesas.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bp.renesas.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[biju.das.jz@bp.renesas.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tuxon.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,TY3PR01MB11346.jpnprd01.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 76F47F3448
X-Rspamd-Action: no action

SGkgQ2xhdWRpdSBCZXpuZWEsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJv
bTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQHR1eG9uLmRldj4NCj4gU2VudDogMDUg
RmVicnVhcnkgMjAyNiAxMzowMA0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDUvN10gZG1hZW5naW5l
OiBzaDogcnotZG1hYzogQWRkIHN1c3BlbmQgdG8gUkFNIHN1cHBvcnQNCj4gDQo+IEhpLCBCaWp1
LA0KPiANCj4gT24gMS8yNi8yNiAxNzoyOCwgQmlqdSBEYXMgd3JvdGU6DQo+ID4gSGkgQWxsLA0K
PiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IEJpanUgRGFz
DQo+ID4+IFNlbnQ6IDI2IEphbnVhcnkgMjAyNiAxMzoxMg0KPiA+PiBTdWJqZWN0OiBSRTogW1BB
VENIIDUvN10gZG1hZW5naW5lOiBzaDogcnotZG1hYzogQWRkIHN1c3BlbmQgdG8gUkFNDQo+ID4+
IHN1cHBvcnQNCj4gPj4NCj4gDQo+IFsgLi4uIF0NCj4gDQo+ID4+DQo+ID4+IEZvciBzMmlkbGUg
aXNzdWUgb24gUlovRzNMIGlzIERNQSBkZXZpY2UgaXMgaW4gYXNzZXJ0ZWQgc3RhdGUsIG5vdA0K
PiA+PiBmb3J3YXJkaW5nIGFueSBJUlEgdG8gY3B1IGZvciB3YWtldXAuDQo+ID4+DQo+ID4+IEZv
ciBTMlJBTSBpc3N1ZSBvbiBSWi9HM0wgaXMgZHVyaW5nIHN1c3BlbmQgaGFyZHdhcmUgdHVybnMg
RE1BQUNMSw0KPiA+PiBvZmYvIEFzc2VydGVkIHN0YXRlLiBDbG9jayBmcmFtd29yayBpcyBub3Qg
dHVybmluZyBPbiBETUFBQ0xLIGFzIGl0IGNyaXRpY2FsIGNsay4NCj4gPj4NCj4gPj4gQ2FuIHlv
dSBwbGVhc2UgY2hlY2sgeW91ciBURi1BIGZvciB0aGUgc2Vjb25kIGNhc2U/IEZpcnN0IGNhc2Us
DQo+ID4+IFJaL0czUyBtYXkgb2sgZm9yIHJlc2V0IGFzc2VydCBzdGF0ZSwgaXQgY2FuIGZvcndh
cmQgSVJRcyB0byBDUFUuDQo+ID4NCj4gPiBKdXN0IHRvIHN1bW1hcml6ZSwgY3VycmVudGx5IHRo
ZXJlIGFyZSAyIGRpZmZlcmVuY2VzIGlkZW50aWZpZWQgYmV0d2VlbiBSWi9HM1MgYW5kIFJaL0cz
TDoNCj4gPg0KPiA+IFNvQyBkaWZmZXJlbmNlcyBmb3IgczJpZGxlOg0KPiA+DQo+ID4gUlovRzNT
OiBDYW4gd2FrZSB0aGUgc3lzdGVtIGlmIHRoZSBETUEgZGV2aWNlIGlzIGluIHRoZSBhc3NlcnQg
c3RhdGUNCj4gPg0KPiA+IFJaL0czTDogQ2Fubm90IHdha2UgdGhlIHN5c3RlbSBpZiB0aGUgRE1B
IGRldmljZSBpcyBpbiB0aGUgYXNzZXJ0IHN0YXRlLg0KPiA+DQo+ID4NCj4gPiBURi1BIGRpZmZl
cmVuY2VzIGZvciBzMnJhbToNCj4gPg0KPiA+IFJaL0czUzogVEZfQSB0dXJucyBvbiBETUFfQUNM
SyBkdXJpbmcgYm9vdC9yZXN1bWUuDQo+ID4NCj4gPiBSWi9HM0w6IFRGX0EgZG9lcyBub3QgaGFu
ZGxlIERNQV9BQ0xLIGR1cmluZyBib290L3Jlc3VtZS4NCj4gDQo+IEknbSBzZWVpbmcgYXQgWzFd
IHlvdSBhcmUgYWRkcmVzc2luZyB0aGVzZSBkaWZmZXJlbmNlcyBpbiB0aGUgY2xvY2svcmVzZXQg
ZHJpdmVycy4gV2l0aCB0aGF0LCBhcmUgeW91DQo+IHN0aWxsIGNvbnNpZGVyaW5nIHRoaXMgcGF0
Y2ggaXMgYnJlYWtpbmcgeW91ciBzeXN0ZW0/DQo+IA0KDQpTdGlsbCwgdGhpbmtpbmcgd2hldGhl
ciB0byBhZGQgY3JpdGljYWwgcmVzZXQgb3IgZ28gd2l0aCBTb0MgcXVpcmsgaW4gRE1BIGRyaXZl
ci4NClNvbWUgU29DcyBuZWVkIERNQSBzaG91bGQgYmUgZGVhc3NlcnRlZCBsaWtlIGNyaXRpY2Fs
IGNsb2NrIA0KdGhhdCBjYW4gYmUgaGFuZGxlZCBlaXRoZXINCg0KMSkgQWRkIGEgc2ltcGxlIFNv
QyBxdWlyayBpbiBETUEgZHJpdmVyDQoNCk9yDQoNCjIpIEltcGxlbWVudCBjcml0aWNhbCByZXNl
dCBpbiBTb0Mgc3BlY2lmaWMgY2xvY2sgZHJpdmVyIGFuZCBjaGVjayBmb3IgYWxsIHJlc2V0cy4N
Cg0KSXMgc2ltcGxlIFNvQyBxdWlyayBpbiBETUEgZHJpdmVyLCBzb21ldGhpbmcgY2FuIGJlIGRv
bmUgZm9yIFJaL0cyTCBmYW1pbHkgU29Dcz8NCg0KQ2hlZXJzLA0KQmlqdQ0KDQo=

