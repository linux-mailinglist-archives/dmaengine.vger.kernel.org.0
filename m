Return-Path: <dmaengine+bounces-10802-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJ4NFR7fE2qdGwcAu9opvQ
	(envelope-from <dmaengine+bounces-10802-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 07:33:18 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A54525C5ED0
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 07:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 577A23007F79
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 05:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12BA3290AF;
	Mon, 25 May 2026 05:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="dUxHW8Zp"
X-Original-To: dmaengine@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010023.outbound.protection.outlook.com [52.101.201.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F7D4317D
	for <dmaengine@vger.kernel.org>; Mon, 25 May 2026 05:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779687195; cv=fail; b=cFVtQiWT2ogF1YEbpPy0uZmmBBoRdZ/2IGZFQF7EtpmXPZQu3li1839vdPuHN/0fTtiO43uJU5cpbMfhOXe4EsGKoiv2YVSm0QsXzj/hbLA0QeY4Q5vG7Y80jwEuW7Qx3IVrPwb+laNXkeE2MRXYsDDejUbXY0EIsXno/er7OWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779687195; c=relaxed/simple;
	bh=sEoWRKStX7SujV4hrOIzGwPW9J8DiwH985GIL/qHnYE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ePYZ3j8qZdsIrVECDMqIiFyYZp1BSxAekQEvZVNKLBcnMB7sNkDEwNzEputEUMBKTurqLMoTfAFePAQ1Bn5TZcDf1wlVDL0iDFCYwmKy/24YOSpyuJ8WXTGA9RFatnwIjmh9PDgIVLW1N2Uik8FKGa8VkI/N1UN2ymiCyCx4OR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=dUxHW8Zp; arc=fail smtp.client-ip=52.101.201.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D9SvXVX5Q+nyTSyynfDXh8pKrQwwuoNG8iWRw9s2YIBnNstmmRfmMJPws6SrGFxaHJIZVoMaLVwPYojzxvuAxtbkUN6coT6a9ae9cobXn2T3rq77Vctil4AENVTwftzPsvcmc/Lx36CuXJaVohfQyfJL22NcWZexeT9KKOv7i8vAU0Z81Zp3oltB3JgpZKPBMIPIMe2pZyqfmDm8XaxXLiQ8XXlbkerIZnhqlxiM3DX+zjgPSJkUtNA3izq3mm5C4zDYXJHaTUWpPG1QXNIDE+BNDoajN7+5sT4xlpx7JbTM3Aj0VKRvpObL49uS0Hge/rSnge4hUnZg587TRps8QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sEoWRKStX7SujV4hrOIzGwPW9J8DiwH985GIL/qHnYE=;
 b=cAZ2+WD1nNUNF/OsIaK2PL+yXDxYHmOmQZCOpojjwTLk4/57TzZ199i0NKn4UeCwrqi/3bHqmiMZr+2ZG96Xol1l7lNUlsQtCldR0F3FcpJHtOc7FcsiJs9mowjlhMhK/Sv/HqkbTiQjhcxtK0oHpCAaX+/4d9HbpCqk6CybTzpVbA0yZJyn7M1/B649hA3SImIeRqsUPqezSgTm1MJfBcel8hUj2kpkjYPbPnt2hlaEkf4QH/sBT8/6TolY/4XJn+rLjGMWyDtkPlngFXtDCH623jLc2hEEVNDlK63h1m6qt/s2lNY1lNRk1hp0moVuaMna/vqkHUatuG7Vsrbd3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sEoWRKStX7SujV4hrOIzGwPW9J8DiwH985GIL/qHnYE=;
 b=dUxHW8Zp+kuWFIlQN1t10h4IptVuM+RXkCpED/2ZU2ndsX4yWzeTtavBFZIR10ctNDmkoSYmM5f4aHQQCywNZjyWOlvZ1Lg1fkYB15gZ4s1UTXhFDfvbgJaYmwX6WScpAjLO8cwscktlHJRuE87lTQkq0OdZ3PKLrxAx/57/JAF5QmdTavtheOVcdLy1FSE1RInqxz+GTq1CNWnXFiF5xLas3UPHf1PE4qGdW8r4/GGWVkHZcjOMqV4xjyU8WdOBvQbdwohM6KkL9GKAoHue/l1b0/ZiuG/8X34qNs4rAouJE7ceInTN1a5ArztsC03aGgcCyRDiGZlYF0vTvIHGwQ==
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by DM4PR03MB6142.namprd03.prod.outlook.com (2603:10b6:5:395::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 05:33:11 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%4]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 05:33:10 +0000
From: "NG, TZE YEE" <tze.yee.ng@altera.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "vkoul@kernel.org" <vkoul@kernel.org>, "Frank.Li@kernel.org"
	<Frank.Li@kernel.org>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>
Subject: Re: [PATCH] dmaengine: dw-axi-dmac: drop redundant DMAC enable in
 block start
Thread-Topic: [PATCH] dmaengine: dw-axi-dmac: drop redundant DMAC enable in
 block start
Thread-Index: AQHc51ufSeHrBAEXi0uU9S9n9q6gNrYU+keAgAlG8oA=
Date: Mon, 25 May 2026 05:33:10 +0000
Message-ID: <a9972eba-bb57-45f0-932a-407e7d0b7114@altera.com>
References:
 <060733464e19298f670cd269d4849f2092644923.1779172907.git.tze.yee.ng@altera.com>
 <20260519075254.4C106C2BCC6@smtp.kernel.org>
In-Reply-To: <20260519075254.4C106C2BCC6@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB5950:EE_|DM4PR03MB6142:EE_
x-ms-office365-filtering-correlation-id: dc43f04b-4e6d-4886-ae6a-08deba1f1be9
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003|38070700021|55112099003|5023799004|11063799006|6133799003|4143699003|4133799003;
x-microsoft-antispam-message-info:
 G5r1Vr3DJrnqNv/Miwe1OG+J44J1rr+jnoFs74KDX4b/FanUMI0Pn9oSpuBLX2azDmt/fJhXGZVF6GNpDzZ+aqnX9EARoM3LFtwSTBW7LM+cswy884XN4eMbAoxmYzMvby3n+mN+3q/4JCv6HOBBz96rQTY9HKTg6TOzumJXqttbOiYu7LOiC5OlOL5a/ADcB0ViL6jHlEe+T+lYVyMOjTiLw0HWQdKvo9LSj46ALNSAMsVCsKclRttiRSJODGOt0XWwgy45Ky1U6B4X+rFIEr+ovC2e92T2HbLfKilW8q8Wla8hRMPFeiDHWF5NGtnoR3Sh7tISWW/9PeZMjIRoUiWCuGC0HpBj59o70R1o5AESYUF74HoqErYppImrsA06UZoO0UbZi/Mi5i6kezPlaHKvkjrHADMn8dV/xvTgeKiC1AD/Dt0OLkCJWbg7itTkMlnVBZ5fYpW6xKMOjKdha2YmMJB8m3RRQWBUffQutcdEhsOIx3AT7wMIDegvLUKCR5BBaecNRuqHp6kbbH+SNhMHfZzUMqQ+mXkAWST/g87cF5sx32oB6iJfMHvuY8bhXbT48njLdrRhYrb2+z+m0+vJsXOERHGy4GbMANVXqNSKQc8zeKD5yL7b2gyBd1O5yV5ebr/m9egRw1QElm3RuASNRRA9RgTZD3uIIdizawKp9ej7pElHoIecC2/VT1Fl
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003)(38070700021)(55112099003)(5023799004)(11063799006)(6133799003)(4143699003)(4133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QzgyL0ZHOFBpbnF2clJ6WktibU1ZdWlDcWlmOUxpT3VmMGVMZTBoVDJaMWhr?=
 =?utf-8?B?cnNRZnZKb09WOTV6L21qY1d1ekxmMjZraEduYXUzcEpSTU9oNDF6NDgwdnJF?=
 =?utf-8?B?OUtWeVhaODFoOHNkRGw3eEw0T2NydVgzMFozLzZwZTQxNFdLRzhVbVRJWFBr?=
 =?utf-8?B?a0ZzbWVlbXZrNGNFZ1RPdllEVzR5QVUwZ2xwSXhERFRsdTQ1cXdMWmY2T2pX?=
 =?utf-8?B?YlliTTkzNGVmUFBJblNOb0dXQk1tY2J2dHNiaUl3THM4SkJmRFN5ZkFadEVi?=
 =?utf-8?B?RkNyN1A1dytmby9EK1BUS1NzVVo4eG1yaXM5U1UzR1UxWWRZejNQcEE3RGpo?=
 =?utf-8?B?OFg3RG45WXVQc3IwZ2xUcFp5aUZ2d1YyTlowZU1xTTViRysyZ01melRERUp4?=
 =?utf-8?B?MlVGaWoyYS9la2p2d3l2MG9WaVd0M3UwcXhWc3RjYmVVM25NcmRHM0o1ektS?=
 =?utf-8?B?YWsrRmNJVk1rcHowRnoyR25INHlUc3R0aDJRVjhkMjl0aGI5ZjFMYlVBRW4r?=
 =?utf-8?B?aC9jaFRkODRpZzkwZEg5V1M3cXB5NVhnNEwwZ3BkdTBpOWYyKzg0dTg2Wnll?=
 =?utf-8?B?VWtMZzZqekNnZVkxWDhJOGMyYlZKUVJDd1Y1elpkZVJGdERUUkJZdWZqdklY?=
 =?utf-8?B?ZldlWkZYenRvWXh2WWFEOWRDZFRnc3pQOEt2UTliSTBqYUpkNjBFa0hNN1dm?=
 =?utf-8?B?RG9TWVVqanBES0U3OUNxN1FKV1B3Tyt6eTR3TVNtVmR3UmxNTlF5ckFmTFN0?=
 =?utf-8?B?bmh5bHdYdXlxTDFiaENyUFVQdi81Q2dIVWh6NmIwZHRiYVM2M0c1QUQrOHZE?=
 =?utf-8?B?MEp1YjU3UDV6L0ZZSDF2NklOd2FxOWJrRytXZERBMXcybG03S0l6b2hoZEUr?=
 =?utf-8?B?OC9DZHF5ejhubWQ1eWx3YmNONHowSm5ZWVJhRFZ2VTA5UzN6VXRHSktqems5?=
 =?utf-8?B?cy9waHdRdm9ZRmJldkFqcVFVemZjV0ZmYlk5VFJ5SVR5bERITHhkMGxGWjFh?=
 =?utf-8?B?cDVCcncxNDFTd0NYT0FuNjJWMVpzWDhhNytzS0szaWVFL3FHSndvWTg3QWxu?=
 =?utf-8?B?VGk4ZERiOWlCbnY0ME9Tc1BpOGsyQTkvWTBRbEJzSHVpeXRPSmJUUlRmOERZ?=
 =?utf-8?B?eUVRSCtlaXp0VmJmQVk4Y0JXYzI0TXdFd1lmR2pvakxSOHZwMVBrY21IL2hr?=
 =?utf-8?B?cmxxVXhXS0RCeEwyRHRQSjhPWFRhRU9jNnBFMnZzdGo5QVZ4ak9FbUs1dU0y?=
 =?utf-8?B?ZG5hZHlLczE2MEl2T1pTWm1UVG9rZk5sUmZURFJKME1DVHZEQW1Ma0RBWFZy?=
 =?utf-8?B?K2hXcHVtb3dOWWgvSi80NGdmbVRtaU5MeGRaa0NBcmQ1b2FsUEYyakh4MzFv?=
 =?utf-8?B?S0NqTW1zNVBFemkwQmNDV0dmeW84eGpBbFRQaEdmcUZ0VVN2TGs4amVMa1Y1?=
 =?utf-8?B?UThmMkgvS3ZoQS9ZVW5lWUwvRHNSaGZlVzlwdEJFb0UzSGxRK2RLdVZycWpi?=
 =?utf-8?B?MFpNM0N2c2xlbTZrZTA4WGI0RGFIVHF3RzZVWS9WdFFMQzRCR3BZUFB5Q3hE?=
 =?utf-8?B?d1E0R2FibnhuL1g2NzBHaHlSZ3drM2JlckdQRkg4ZTQ2NzdnYllJMVJtcFFR?=
 =?utf-8?B?b0ZyUklmeGFJYTBEbVdzSHBUbmp6T2QwR2s5bjA3UWpWbzV3VjVpWDZ2MTlD?=
 =?utf-8?B?OERjb3lQYTRtS1RUOXhJRzdmOEsveSs0RWlFSlJIaWYrYUNVMER2Tkc3OGFL?=
 =?utf-8?B?NDcwZ2hjaFkyL2x0MmRkdXRMeGs2R3pDNndVWVNWVWR0TUs3M0NOcmo3ei9N?=
 =?utf-8?B?WmtiVFFmVWptSS82bGg0T0RUdkova2dyZDFjR0pqZGZVOXNYN1ZOUkIvU1B1?=
 =?utf-8?B?ZFl5L05BVlNBQ0pLSytvMWwrekFzMDVleFNNWThFSTdSMTAvbXBJb3NhamYv?=
 =?utf-8?B?dkJCWG9aNENDaU9uR1dXYjRlWjNDWVVoSkpYc2ViZkxpVzZBSFMzZVVodHdI?=
 =?utf-8?B?QVhhRmlQY1ZKM09Tc0w0TjNFWnl0bGNCNGV4U1Y5bFRYTTBlM3BFd0lVSkNB?=
 =?utf-8?B?LzFtc2R3QXUyK2hYRjB2RlY4NjhFWmFQaHExc0NnMkllN0EvZzV5UCt4dVFY?=
 =?utf-8?B?QStDdlZWVlZFLzdRWkF5ZGdpTzdJS0kyNGhXZmxvaWcrZUlqNDdxQWlSNUkz?=
 =?utf-8?B?NFg0cWp0aHdoTjBkODU3V1k4cC8rL2h0MnU3akdCcVVlVFNiREVnYytGcmpm?=
 =?utf-8?B?RHh4RFlpOU9LTnY1WUFGaVZJMmRHaVB0Um93N29BMFZsYzU5eVNrNnZWWlFi?=
 =?utf-8?B?UDBXdFZHMy9rdGNTTE05dEdzSkt2Z3NnR3NqZzhHMFFrT2d3Tm1NZlA3cVpH?=
 =?utf-8?Q?WvyN6oW93r1rrAUk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC32F5DB02D67C48B5C489A621305171@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc43f04b-4e6d-4886-ae6a-08deba1f1be9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 05:33:10.7956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BqV7SMtbt2zt59GfchiKta/fsAZ6lE0MUrybGwRCOOr/BTIUtczsaFUmvdBM9TGGdBXbW/eXyTkKYcheODrt8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6142
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10802-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[altera.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tze.yee.ng@altera.com,dmaengine@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	REDIRECTOR_URL(0.00)[aka.ms];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,aka.ms:url,sashiko.dev:url,altera.com:email,altera.com:mid,altera.com:dkim]
X-Rspamd-Queue-Id: A54525C5ED0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gMTkvNS8yMDI2IDM6NTIgcG0sIHNhc2hpa28tYm90QGtlcm5lbC5vcmcgd3JvdGU6DQo+IFtZ
b3UgZG9uJ3Qgb2Z0ZW4gZ2V0IGVtYWlsIGZyb20gc2FzaGlrby1ib3RAa2VybmVsLm9yZy4gTGVh
cm4gd2h5IHRoaXMgaXMgaW1wb3J0YW50IGF0IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5k
ZXJJZGVudGlmaWNhdGlvbiBdDQo+DQo+IFRoYW5rIHlvdSBmb3IgeW91ciBjb250cmlidXRpb24h
IFNhc2hpa28gQUkgcmV2aWV3IGZvdW5kIDEgcG90ZW50aWFsIGlzc3VlKHMpIHRvIGNvbnNpZGVy
Og0KPiAtIFtIaWdoXSBVbnNhZmUgaGFyZHdhcmUgYWNjZXNzIGR1ZSB0byBhc3luY2hyb25vdXMg
UE0gcmVzdW1lIGFuZCB1bmhhbmRsZWQgc3lzdGVtIHN1c3BlbmQuDQo+IC0tDQo+DQo+IGNvbW1p
dCA4MjM3MTVhNTI3YzY1MzliZTQ1NjE5ZDJkNjIyMWEyM2U2YmFhNzY2DQo+IEF1dGhvcjogTmly
YXZrdW1hciBMIFJhYmFyYSA8bmlyYXZrdW1hcmxheG1pZGFzLnJhYmFyYUBhbHRlcmEuY29tPg0K
Pg0KPiBkbWFlbmdpbmU6IGR3LWF4aS1kbWFjOiBkcm9wIHJlZHVuZGFudCBETUFDIGVuYWJsZSBp
biBibG9jayBzdGFydA0KPg0KPiBUaGlzIGNvbW1pdCByZW1vdmVzIGEgcmVkdW5kYW50IGF4aV9k
bWFfZW5hYmxlKCkgY2FsbCBmcm9tDQo+IGF4aV9jaGFuX2Jsb2NrX3hmZXJfc3RhcnQoKSwgYXMg
dGhlIGNvbnRyb2xsZXIgaXMgZXhwZWN0ZWQgdG8gYmUgYWxyZWFkeQ0KPiBlbmFibGVkIGJlZm9y
ZSBhIHRyYW5zZmVyIHN0YXJ0cy4NCj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2RtYS9kdy1h
eGktZG1hYy9kdy1heGktZG1hYy1wbGF0Zm9ybS5jIGIvZHJpdmVycy9kbWEvZHctYXhpLWRtYWMv
ZHctYXhpLWRtYWMtcGxhdGZvcm0uYw0KPj4gLS0tIGEvZHJpdmVycy9kbWEvZHctYXhpLWRtYWMv
ZHctYXhpLWRtYWMtcGxhdGZvcm0uYw0KPj4gKysrIGIvZHJpdmVycy9kbWEvZHctYXhpLWRtYWMv
ZHctYXhpLWRtYWMtcGxhdGZvcm0uYw0KPj4gQEAgLTQzNyw4ICs0MzcsNiBAQCBzdGF0aWMgdm9p
ZCBheGlfY2hhbl9ibG9ja194ZmVyX3N0YXJ0KHN0cnVjdCBheGlfZG1hX2NoYW4gKmNoYW4sDQo+
PiAgICAgICAgICAgICAgICByZXR1cm47DQo+PiAgICAgICAgfQ0KPj4NCj4+IC0gICAgIGF4aV9k
bWFfZW5hYmxlKGNoYW4tPmNoaXApOw0KPj4gLQ0KPg0KPiBXaWxsIHJlbW92aW5nIHRoaXMgY2F1
c2UgYSByZWdyZXNzaW9uIHdpdGggc3lzdGVtIHN1c3BlbmQ/DQo+DQo+IFRoZSBkcml2ZXIgY3Vy
cmVudGx5IGFwcGVhcnMgdG8gcmVseSBvbmx5IG9uIFNFVF9SVU5USU1FX1BNX09QUyBhbmQgbGFj
a3MNCj4gc3lzdGVtIHNsZWVwIFBNIG9wZXJhdGlvbnMuIElmIHRoZSBzeXN0ZW0gc3VzcGVuZHMg
d2hpbGUgYSBjaGFubmVsIGlzDQo+IGFsbG9jYXRlZCwgdGhlIHJ1bnRpbWUgUE0gdXNhZ2UgY291
bnQgcmVtYWlucyBncmVhdGVyIHRoYW4gemVybywgYnV0IHBvd2VyDQo+IHRvIHRoZSBjb250cm9s
bGVyIG1heSBiZSBjdXQuIE9uIHJlc3VtZSwgdGhlIGhhcmR3YXJlIHN0YXRlIHN1Y2ggYXMNCj4g
RE1BQ19DRkcgaXMgcmVzZXQuDQo+DQo+IEJlY2F1c2UgdGhlcmUgYXJlIG5vIHN5c3RlbSBzbGVl
cCBjYWxsYmFja3MgbGlrZSBwbV9ydW50aW1lX2ZvcmNlX3N1c3BlbmQNCj4gYW5kIHBtX3J1bnRp
bWVfZm9yY2VfcmVzdW1lIHRvIGNhbGwgYXhpX2RtYV9yZXN1bWUoKSwgdGhlIGhhcmR3YXJlIHNl
ZW1zDQo+IHRvIHJlbWFpbiBkaXNhYmxlZCBhZnRlciBhIHN1c3BlbmQvcmVzdW1lIGN5Y2xlLg0K
Pg0KPiBQcmV2aW91c2x5LCB0aGlzIGF4aV9kbWFfZW5hYmxlKCkgY2FsbCBpbiBheGlfY2hhbl9i
bG9ja194ZmVyX3N0YXJ0KCkNCj4gaW5hZHZlcnRlbnRseSByZXN0b3JlZCB0aGUgRE1BQ19FTl9N
QVNLIGJpdCBmb3IgdGhlIG5leHQgdHJhbnNmZXIuIFdpdGggaXQNCj4gcmVtb3ZlZCwgd2lsbCB0
aGlzIGNhdXNlIGEgcmVncmVzc2lvbiB3aGVyZSB0aGUgaGFyZHdhcmUgc2lsZW50bHkgcmVtYWlu
cw0KPiBkaXNhYmxlZCBhZnRlciBzeXN0ZW0gcmVzdW1lPw0KPg0KPiBXaGlsZSBsb29raW5nIGF0
IHRoZSBwb3dlciBtYW5hZ2VtZW50IGhlcmUsIGlzIGl0IHNhZmUgZm9yIGNoYW5uZWwNCj4gYWxs
b2NhdGlvbiB0byB1c2UgcG1fcnVudGltZV9nZXQoKT8NCj4NCj4gZHJpdmVycy9kbWEvZHctYXhp
LWRtYWMvZHctYXhpLWRtYWMtcGxhdGZvcm0uYzpkbWFfY2hhbl9hbGxvY19jaGFuX3Jlc291cmNl
cygpIHsNCj4gICAgICAuLi4NCj4gICAgICBwbV9ydW50aW1lX2dldChjaGlwLT5kZXYpOw0KPiAg
ICAgIC4uLg0KPiB9DQo+DQo+IFNpbmNlIHBtX3J1bnRpbWVfZ2V0KCkgcXVldWVzIGFuIGFzeW5j
aHJvbm91cyByZXN1bWUgYW5kIHJldHVybnMNCj4gaW1tZWRpYXRlbHksIGEgY2xpZW50IGNvdWxk
IGFsbG9jYXRlIGEgY2hhbm5lbCBhbmQgaW1tZWRpYXRlbHkgaXNzdWUgYQ0KPiB0cmFuc2Zlci4g
VGhpcyB3b3VsZCBjYXVzZSBheGlfY2hhbl9ibG9ja194ZmVyX3N0YXJ0KCkgdG8gZXhlY3V0ZSBh
bmQNCj4gdW5jb25kaXRpb25hbGx5IHdyaXRlIHRvIEFQQiBoYXJkd2FyZSByZWdpc3RlcnM6DQo+
DQo+IGRyaXZlcnMvZG1hL2R3LWF4aS1kbWFjL2R3LWF4aS1kbWFjLXBsYXRmb3JtLmM6YXhpX2No
YW5fYmxvY2tfeGZlcl9zdGFydCgpIHsNCj4gICAgICAuLi4NCj4gICAgICBheGlfY2hhbl9jb25m
aWdfd3JpdGUoY2hhbiwgJmNvbmZpZyk7DQo+ICAgICAgLi4uDQo+IH0NCj4NCj4gSWYgdGhlIGJh
Y2tncm91bmQgUE0gd29ya2VyIGhhc24ndCB5ZXQgY29tcGxldGVkIGF4aV9kbWFfcnVudGltZV9y
ZXN1bWUoKQ0KPiB0byBlbmFibGUgdGhlIGNvcmUgY2xvY2tzLCBjb3VsZCB0aGVzZSByZWdpc3Rl
ciBhY2Nlc3NlcyB0cmlnZ2VyIGFuIGV4dGVybmFsDQo+IGJ1cyBhYm9ydD8gRG9lcyBkbWFfY2hh
bl9hbGxvY19jaGFuX3Jlc291cmNlcygpIG5lZWQgdG8gdXNlDQo+IHBtX3J1bnRpbWVfZ2V0X3N5
bmMoKSBpbnN0ZWFkIHRvIGF2b2lkIGEgcmVncmVzc2lvbiBoZXJlPw0KPg0KPj4gICAgICAgIGNv
bmZpZy5kc3RfbXVsdGJsa190eXBlID0gRFdBWElETUFDX01CTEtfVFlQRV9MTDsNCj4+ICAgICAg
ICBjb25maWcuc3JjX211bHRibGtfdHlwZSA9IERXQVhJRE1BQ19NQkxLX1RZUEVfTEw7DQo+PiAg
ICAgICAgY29uZmlnLnR0X2ZjID0gRFdBWElETUFDX1RUX0ZDX01FTV9UT19NRU1fRE1BQzsNCj4N
Cj4gLS0NCj4gU2FzaGlrbyBBSSByZXZpZXcgwrcgaHR0cHM6Ly9zYXNoaWtvLmRldi8jL3BhdGNo
c2V0LzA2MDczMzQ2NGUxOTI5OGY2NzBjZDI2OWQ0ODQ5ZjIwOTI2NDQ5MjMuMTc3OTE3MjkwNy5n
aXQudHplLnllZS5uZ0BhbHRlcmEuY29tP3BhcnQ9MQ0KDQpIaSBtYWludGFpbmVycywNCg0KVGhh
bmsgeW91IGZvciB0aGUgZGV0YWlsZWQgcmV2aWV3Lg0KDQpPbiByZW1vdmluZyBheGlfZG1hX2Vu
YWJsZSgpIGZyb20gYXhpX2NoYW5fYmxvY2tfeGZlcl9zdGFydCgpDQotLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KWW91IGFyZSBj
b3JyZWN0IHRoYXQgdGhpcyBjYWxsIHdhcyBlZmZlY3RpdmVseSBtYXNraW5nIGEgZ2FwIGluIG91
cg0Kc3lzdGVtLXNsZWVwIHBvd2VyIG1hbmFnZW1lbnQsIG5vdCBtZXJlbHkgcGVyZm9ybWluZyBh
IHJlZHVuZGFudA0Kd3JpdGUgb24gdGhlIG5vcm1hbCBydW50aW1lLVBNIHBhdGguDQoNCk9uIHRo
ZSBleHBlY3RlZCBwYXRoLCB0aGUgY29udHJvbGxlciBpcyBhbHJlYWR5IGVuYWJsZWQ6IHByb2Jl
IGNhbGxzDQpheGlfZG1hX3Jlc3VtZSgpIGRpcmVjdGx5LCBhbmQgYXhpX2RtYV9ydW50aW1lX3Jl
c3VtZSgpIGNhbGxzIHRoZSBzYW1lDQpoZWxwZXIsIHdoaWNoIHNldHMgRE1BQ19DRkcuRE1BQ19F
TiBhbmQgcmUtZW5hYmxlcyBpbnRlcnJ1cHRzLiBJbiB0aGF0DQpjYXNlLCBheGlfZG1hX2VuYWJs
ZSgpIGF0IHRyYW5zZmVyIHN0YXJ0IGlzIGEgcmVhZC1tb2RpZnktd3JpdGUgbm8tb3AuDQoNCkhv
d2V2ZXIsIHRoZSBkcml2ZXIgY3VycmVudGx5IG9ubHkgcmVnaXN0ZXJzIHJ1bnRpbWUgUE0gY2Fs
bGJhY2tzIHZpYQ0KU0VUX1JVTlRJTUVfUE1fT1BTKCkgYW5kIGhhcyBubyBzeXN0ZW0tc2xlZXAg
aGFuZGxlcnMuIElmIGEgY2hhbm5lbA0KcmVtYWlucyBhbGxvY2F0ZWQgYWNyb3NzIGEgc3lzdGVt
IHN1c3BlbmQvcmVzdW1lIGN5Y2xlLCB0aGUgcnVudGltZQ0KdXNhZ2UgY291bnQgY2FuIHN0YXkg
bm9uLXplcm8gd2hpbGUgcGxhdGZvcm0gcG93ZXIgb3IgcmVzZXQgY2xlYXJzDQpyZWdpc3RlciBz
dGF0ZSBzdWNoIGFzIERNQUNfQ0ZHLiBCZWNhdXNlIGF4aV9kbWFfcnVudGltZV9yZXN1bWUoKSBp
cw0Kbm90IGludm9rZWQgaW4gdGhhdCBzaXR1YXRpb24sIHRoZSBnbG9iYWwgRE1BQyBlbmFibGUg
Yml0IG1heSByZW1haW4NCmNsZWFyIGV2ZW4gdGhvdWdoIHRoZSBkZXZpY2UgaXMgc3RpbGwgY29u
c2lkZXJlZCBydW50aW1lLWFjdGl2ZS4gVGhlDQpyZW1vdmVkIGF4aV9kbWFfZW5hYmxlKCkgaGFw
cGVuZWQgdG8gcmVzdG9yZSBETUFDX0VOIG9uIHRoZSBuZXh0DQp0cmFuc2Zlcjsgd2l0aG91dCBp
dCwgYSB0cmFuc2ZlciBtYXkgYmUgcHJvZ3JhbW1lZCB3aGlsZSB0aGUNCmNvbnRyb2xsZXIgcmVt
YWlucyBnbG9iYWxseSBkaXNhYmxlZC4NCg0KU28gSSBhZ3JlZSB0aGlzIGlzIGEgdmFsaWQgY29u
Y2VybiBmb3Igc3lzdGVtIHN1c3BlbmQvcmVzdW1lIHdpdGggYW4NCmFsbG9jYXRlZCBjaGFubmVs
LiBUaGUgY2xlYW51cCBpbiB0aGlzIHBhdGNoIGlzIHN0aWxsIGNvcnJlY3QgZm9yIHRoZQ0Kd2Vs
bC1kZWZpbmVkIHJ1bnRpbWUtUE0gcGF0aCwgYnV0IGl0IHNob3VsZCBub3QgbGFuZCB3aXRob3V0
IGFkZHJlc3NpbmcNCnRoZSB1bmRlcmx5aW5nIFBNIGlzc3VlIChvciBkb2N1bWVudGluZyB0aGF0
IGNoYW5uZWxzIG11c3QgYmUgZnJlZWQNCmJlZm9yZSBzeXN0ZW0gc3VzcGVuZCkuDQoNCkZvbGxv
dy11cCBwYXRjaA0KLS0tLS0tLS0tLS0tLS0tDQpJIHdpbGwgc2VuZCBhIHNlcGFyYXRlIHBhdGNo
IGluIHRoaXMgc2VyaWVzIHRoYXQ6DQogIDEpIEFkZHMgc3lzdGVtLXNsZWVwIFBNIG9wcyB1c2lu
ZyBwbV9ydW50aW1lX2ZvcmNlX3N1c3BlbmQoKSBhbmQNCiAgICAgcG1fcnVudGltZV9mb3JjZV9y
ZXN1bWUoKSBzbyB0aGF0IHN1c3BlbmQvcmVzdW1lIHJldXNlcw0KICAgICBheGlfZG1hX3N1c3Bl
bmQoKSAvIGF4aV9kbWFfcmVzdW1lKCkgYW5kIHJlc3RvcmVzIGNsb2NrcyBhbmQNCiAgICAgRE1B
Q19DRkcgZXZlbiB3aGVuIHRoZSBydW50aW1lIHVzYWdlIGNvdW50IGlzIG5vbi16ZXJvOyBhbmQN
Cg0KICAyKSBSZXBsYWNlcyBwbV9ydW50aW1lX2dldCgpIHdpdGggcG1fcnVudGltZV9yZXN1bWVf
YW5kX2dldCgpIGluDQogICAgIGRtYV9jaGFuX2FsbG9jX2NoYW5fcmVzb3VyY2VzKCksIHdpdGgg
cHJvcGVyIGVycm9yIGhhbmRsaW5nLCBzbw0KICAgICBjbG9ja3MgYXJlIGVuYWJsZWQgYmVmb3Jl
IGEgY2xpZW50IGNhbiBpbW1lZGlhdGVseSBzdWJtaXQgYQ0KICAgICB0cmFuc2ZlciBhZnRlciBh
bGxvY2F0aW9uLg0KDQpPbiBwbV9ydW50aW1lX2dldCgpIGluIGRtYV9jaGFuX2FsbG9jX2NoYW5f
cmVzb3VyY2VzKCkNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tDQpZb3UgYXJlIGFsc28gcmlnaHQgdGhhdCBwbV9ydW50aW1lX2dldCgpIG9u
bHkgcXVldWVzIGFuIGFzeW5jaHJvbm91cw0KcmVzdW1lLiBhbGxvY19jaGFuX3Jlc291cmNlcygp
IGRvZXMgbm90IHRvdWNoIE1NSU8sIGJ1dCBhIGNsaWVudCBtYXkNCmNhbGwgcHJlcC9pc3N1ZV9w
ZW5kaW5nIGltbWVkaWF0ZWx5IGFmdGVyd2FyZCwgYW5kDQpheGlfY2hhbl9ibG9ja194ZmVyX3N0
YXJ0KCkgZG9lcyB3cml0ZSBjaGFubmVsIGFuZCBBUEIgcmVnaXN0ZXJzLiBPbg0KcGxhdGZvcm1z
IHdoZXJlIHRob3NlIGFjY2Vzc2VzIHJlcXVpcmUgdGhlIGNvcmUgY2xvY2tzIGVuYWJsZWQsIHRo
YXQNCmNhbiByYWNlIHdpdGggdGhlIHJ1bnRpbWUgUE0gd29ya2VyLiBVc2luZyBwbV9ydW50aW1l
X3Jlc3VtZV9hbmRfZ2V0KCkNCmF2b2lkcyB0aGF0IHJhY2U7IHRoaXMgaXMgaW5kZXBlbmRlbnQg
b2YgcmVtb3ZpbmcgdGhlIHJlZHVuZGFudA0KYXhpX2RtYV9lbmFibGUoKSwgYnV0IHdvcnRoIGZp
eGluZyBpbiB0aGUgc2FtZSBzZXJpZXMuDQoNClRoYW5rcywNClR6ZSBZZWUNCg0K

