Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3494492957
	for <lists+dmaengine@lfdr.de>; Tue, 18 Jan 2022 16:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbiARPE2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Jan 2022 10:04:28 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:28553 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiARPE1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Jan 2022 10:04:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1642518267; x=1674054267;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=NX0IYr9FwZkN0fQ06pGKPhpf9gZHLkHg/7yP192hK5Y=;
  b=nzp6fLGnCMAtu3yzlIsGxG3gqTIKB0CVHNNkN3cPkH8kC8FN7eT+d2uk
   2jg0O2FLXbr4A2YAI9j0cbCvc1PDXRnchp4eLNdJT/GjWYt7tItS9NnNs
   8bQvTWyiSpHL32R2NhWacTqqaU0KLujawDjJJbyGBL31diVkEsRrMne5w
   /6KKcDy0clGR5Bpyo5Rae1xsUAjOy6F572lKhil7wLQB46OvU6qFk5PDC
   xtf3qZ8HNPm3MTEvE/jam2Q0S05R1QlmeLsZAf1pDmc4XA9qxAc842C4E
   eVr9IfA1L2kPvhtUr0AosS8SXtKngMDSZeWgiiidC3bSRwQTaLQMyRalM
   A==;
IronPort-SDR: cgVFqXWQjMOMQ+OImS1/B6lXvZMp2Np3/CZ7EmmiVbbFYukPWBjo+OyRS0OIeDC2zk693QIvZK
 5pQl7eoalryL8RRQdVGA7XXbZk9lzbs+l3bZtrfnmYV80amiWcGDuzBd2fCN57wuv7yoIiQQus
 MctxLPdUGibZYj82K3oxKW+nhTklVbbS2FH7/9H51xD6BO8AJlJxM/yo2AuKYke1bZJRzUcKDF
 F6uyBHonJnUmlz/+e3fv71PWFZyw/2pvafbraEffImY/S7Sc1CU39HGV7HkBBR0fglhUiWhiQh
 HkDQzwHqmop4ncRGSewc/IFg
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="150024272"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Jan 2022 08:04:24 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 18 Jan 2022 08:04:23 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Tue, 18 Jan 2022 08:04:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILy0qR7DeV/bFM7GWCOvR5TSxATAmkm3mIjTkSNam8eKAl8bpxPkHV4qaQWRJebk2aWm8r9uiP406TQdEcQ2dVGdf/P2s4JOdExRNkwqNiPL/8buygQ1MvRKtnEtod8aL+w3Akyy0nDWtn9yEeOcAR4Zlw945XmoaaSCR1RqsBqTRQB05YyRDyHG9Pb3uVY9raXQbdf9KCWe6Xu7YCQ0wNedhGR/wfuIqx+H1nkn11QR4REE/k7sME+WYZKj3ztvf9TxVrnStoZV8UNLaumB9+Php376lkqdY9qE3XiNqmA2Dh/SmGExryH8XXva/Xu5ycbko3v4G0wY6n7U8HRqew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NX0IYr9FwZkN0fQ06pGKPhpf9gZHLkHg/7yP192hK5Y=;
 b=Vb43BKWR74DPhjNMWMr4lRHXqhhnYGvQULwZ1j+RNcUlcws2msj2qGo/iZ+icXmcm7c0Ld7FGip3vNzJ0rInLDECzB/2JhaKaDaMPClP2LxrFWbXWU5XJF8tBOiK6icfZwPcAW+BFfktubq8Yobds93eZKFA162JOI6CKD8bR2efq5F/7QdKt/gsMHOlFf/+px+c1J2ALOdrERurTDJGj5Mp/UID4jgBAkCPoHxO9M6OlroNuXt7F6Ma8I+RAJPUo/ijEISU4xSw2mt4byGeJZ7f5zRJo9IMy6qaslwS1wKykdd4qUb3BhtYm1qkcsDLF8vcMSYBTRbbg6IL4xZXVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NX0IYr9FwZkN0fQ06pGKPhpf9gZHLkHg/7yP192hK5Y=;
 b=T7WAHpA86ZYMcIxhfv07Y35lV2gHwlPG5D6lu3f4f1jqqsXWt6nNXCHquUBoON7yGmIcLb+FYfGIkVgERFVLSFIxFB8yH/cYLVxbnRVS1nIHpFIYlnmVSDg+t1rUD1PHPOmDkI1+91b6ZAg/JOOWXu6dSyLpzvmmpPrtURPHE6I=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:95::7)
 by MWHPR11MB1837.namprd11.prod.outlook.com (2603:10b6:300:10f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Tue, 18 Jan
 2022 15:04:16 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::6032:bbb2:b522:2ac3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::6032:bbb2:b522:2ac3%9]) with mapi id 15.20.4909.007; Tue, 18 Jan 2022
 15:04:16 +0000
From:   <Conor.Dooley@microchip.com>
To:     <zong.li@sifive.com>, <robh+dt@kernel.org>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <krzysztof.kozlowski@canonical.com>,
        <geert@linux-m68k.org>, <bin.meng@windriver.com>,
        <green.wan@sifive.com>, <vkoul@kernel.org>,
        <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v4 1/3] riscv: dts: Add dma-channels property in dma node
Thread-Topic: [PATCH v4 1/3] riscv: dts: Add dma-channels property in dma node
Thread-Index: AQHYC0KL/MNb3PxEU0is3DMBEj8Ve6xo44WA
Date:   Tue, 18 Jan 2022 15:04:16 +0000
Message-ID: <0735806d-0d42-8e32-03cb-5e67d2482880@microchip.com>
References: <cover.1642383007.git.zong.li@sifive.com>
 <163a2cf11b2aceee2a1b8dc83251576d2371d4a6.1642383007.git.zong.li@sifive.com>
In-Reply-To: <163a2cf11b2aceee2a1b8dc83251576d2371d4a6.1642383007.git.zong.li@sifive.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1084fb59-eba4-4a40-bdf9-08d9da93cbc3
x-ms-traffictypediagnostic: MWHPR11MB1837:EE_
x-microsoft-antispam-prvs: <MWHPR11MB183713B8287335A99788D58898589@MWHPR11MB1837.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:639;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: woxCF51+BNAkSa+r/OeJe5kPzz82Hpqm6BuRK1NjQExQVH8qSC/XM0ivk2/F3hRayD4+OKuGlpcSTsv1id0RfPnh76ckgktd91N2xZtr38y4Zx3fz75qXW+vLNIHAXn6YFdmNBX5kCMtSXpf1Mn7V3HHRjyw1SVALApKQtpPQ0flCpWbK8k+9ES7cjwi4xo4xswzCCBZsJd56KNoR/BwGheUfoBhXEueJr+1rMd4yAqoKZ3/Z4/5U7LoZDT46lOUcq+4HnpsjccBY5z7K2G28tAl3Lyd8t+8c/Od/fcjS08TpcBv1uF8JYeXlGX0GoOWxkudj+AbgIyKlstqxebEggfUEbuMTV7KOg0XUanKKGoVIBw63Yzl1HSEtAubOl67vrq51eouovtdBzGTzUwTYAFtRemwPQOPWaTvDnHdbbjncyBqrJzrqjsRQUG5g6v4LtfSkXFdnl4ASoMIn9C/NTzq9a6WLhQX8fpKQVZJEfRtRk4f74bNYwvHwdyc0F8keLChKVoc+eBoLfj6qh07cJ+8BdRteOrowl7Nmg959RtHbs+yha+tXZ+sdEGICAKNUvZ9AEfZdx4Ip0Ziivb1I9dnfhGjfEZZMFHzhsB94ixsZ2L/dn5nnGTq8e+TMxsJ7x0uTrX8S4j3XgOnu+uMQctZPSXVGiY3+W0PMxMMUtYHKkQjX6+x886S14zmbG90hTcH5M64lduD8gC53JU6Ud/RZ9tUIYTEwO8VIXTg4cmKHM8rAzYiHM/8y2Wkpaknhxd70YgSQWkRlxtMnd+1QAsw7j7AJjE3mH85bZS5eMs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2616005)(31696002)(6512007)(508600001)(6506007)(38100700002)(76116006)(64756008)(38070700005)(91956017)(31686004)(66476007)(66946007)(66446008)(66556008)(921005)(2906002)(8936002)(86362001)(7416002)(316002)(26005)(6486002)(186003)(8676002)(71200400001)(36756003)(53546011)(122000001)(5660300002)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QnJjZ1EwNTUzOVFTRUkxVWZqUE5IRDdqNjVod0liRkg0TlZnOEovRTlUZ0hp?=
 =?utf-8?B?S2FTY1dnZWI5RTRtTmF3OFFWdndvOVRQd1NqWlIxMnM5SzI4KzNXdDVEejBz?=
 =?utf-8?B?SjYwNTQrRXlIT2ZsaVgrWEhsT2kvYmtpbC9pMVhEaWJUQkZLbGsySlk4NXdq?=
 =?utf-8?B?amUzY0dyeUdnaVlEcFdqSWp0aW8yc3hEMXVnckYwYlArUjM4ZkFZZWFvQmh0?=
 =?utf-8?B?d2pRK1lxdU5hVURpT0MyeWo1OXRabDBCeE94WTFpUFdsdmVBdVZ4SjNnaTkr?=
 =?utf-8?B?Rmp3Ky9wUTdVcXFoT0owQXdSRzkvNFpCM3FEbjg1MHo2ZEcyVUN6blFNcTVF?=
 =?utf-8?B?aDRmNURYSEE1RW1RQVppWFE3dGJIT05PeFF2VDBoOFJsclp1bVRRUGJYNkFN?=
 =?utf-8?B?cFRYcm9SRGdaWTI0b3VyVFI1d3BLa2RUWTNLRnpvbzFqU2I3K2UzRGJ0Ritl?=
 =?utf-8?B?d0xHWVRxTVpsSGYzUmtrZG1OL1NXcHM1K0RxSnZuYW0ya3pQV3l0Nis4bHg4?=
 =?utf-8?B?ejNFK0p0WUFTekNTV28wUUN6Zy80akpJWXMxTEZSczR1clZ0ZlB1dFpQWFlU?=
 =?utf-8?B?SnlSNXhPZmE0T1VMMEdUcHRiY3QwQlVvellCeDFtZEFVZGNLNnBFaExuZGxM?=
 =?utf-8?B?VDNhdTRISGFrc053bHRTUC9yQVhQc0dHZ2duYXVQOWh2Q0JVeHJ2bUQxNHhY?=
 =?utf-8?B?T1RBQStSZGVqRi8zaHJSdEEzcjVDU3QzTnNOWC9qeU8wM0hqSVlHdmhLeGxF?=
 =?utf-8?B?YmMzazhWMnhpZkxwaG0wVENhSE1tOHBsVldKQ3p0QzRTaWhacXR0OW94dlJY?=
 =?utf-8?B?dS84UHd4MFNBajJvZ04zazNwa0FQbS9HSlB0OU5ZSkVoTzBvSURwc2hlVTMr?=
 =?utf-8?B?UGpuUU0zUVNUd0NhQUxxY0xydEZSWlpHbE5CVHQvQm1lVjQrVXAwY0xGSndw?=
 =?utf-8?B?L0M0UUhxVmlxYWJvZnhadk1mMUxyTGVyR3RrbUVyVUt4cTZ5ZWtHQVNLMzJQ?=
 =?utf-8?B?OVhQL3BjSE9hTVdwSko3Ly9OR0VLL013enlzejBRTzFPc2N4YmNMYmJZdndS?=
 =?utf-8?B?cTNUY0RjeHFWZ3pDOHNNOTRTelNvNDZabWorM3NlTkhqSTkxRktpNGxCSlcy?=
 =?utf-8?B?ZnB0bVJ1LzQ1SUpuWVdGQ2NEU21jQjUxTEJGakxFKzRja21vaEg5N3UzTis4?=
 =?utf-8?B?Z2NJMGR6d0FOcHZxOGpGcDBNUnIxcExBQmN1Y1pIWHBHeVVaRWlEcEJxc3pj?=
 =?utf-8?B?VUV5YkIreE1QSDZqdkQ4SUpENlp4aSs2dzRzVEZ4S2RHekhzeTBkZlV1ZTM5?=
 =?utf-8?B?RmRqaEV4OXpLVk1LM0Y2TnlUelB1K3FmeUo5Z2VnUTAvcVIvMG9IelZDSi9l?=
 =?utf-8?B?bzRtb3Mwd2k3VVgrOEtQRW51Qit3OFNBblRCRHEwT0tSdlZhdkdEblFSVkhm?=
 =?utf-8?B?b1dTUHZrTERtdHhIQW9zcVA3MUhjc0JHWGdORjdrNlFwdW9oQ1ZLMzZGM3lS?=
 =?utf-8?B?d1RRMkZvVVBqNGpyVG1uSHpRdWRDYWdxbkZTYkQ3eEppY3c3bGUyTW5zZ1Zz?=
 =?utf-8?B?ekJNdFM0NU1ZbVVvOFZyQWMyMnFsWmc5T3drcVZzOWhKS1RuV1pxLzZFd0hw?=
 =?utf-8?B?WWptODJhN1B1cmdKd1FpVTM0dmM4M0tocGp3UER0djRtWjZkOGJSRmZmckFF?=
 =?utf-8?B?aTgzUDNYcnpUNFFXb1UvMHpOS2duWlQ4M3orNFl4VThNbHBOZjQ2cGs0bldI?=
 =?utf-8?B?eVdWSUtWOTRxa0tKTkx3VnQxQ3hhdVdoZDNPWmhhSFg5bjFOWm4vK1VrSXFx?=
 =?utf-8?B?UUk2L2Y0VzRmMmJKeGtxN2JsNWlSWmRiTlN6ZWMrQzVOYlNMK1FBc012RE9s?=
 =?utf-8?B?M2NxdzRxWG9sSjgrM0FTOSsxNUJaRnIyNys3YmQ5TFV4NE9HQWVRazNkcW9H?=
 =?utf-8?B?Y1NaZkdWNnhnRE9NRktsN0FRWjVVRjJiWE5taHhUYW1KUXppZkhaQnlJaW5w?=
 =?utf-8?B?aVdvMGZzRG8yRW94WFZoT2RST1ZIZGNBT0lNSVdnMHlUVWdROEtYZTVra2pi?=
 =?utf-8?B?UEIxODlCaUZMQUNTZU5VUUpXdzJGZ3JHSXJ0azAxWlJ4dTJDMTBWOU9hK3Y5?=
 =?utf-8?B?RTZhb1A3aWVUL0hZRXo4VHNJcXJUNmVvQTFsdnU3OEZKK3laMEJzeitmUDRj?=
 =?utf-8?B?M2M3T2w5Ly9STExSc0U4aW91N0dScnh6V1I0bUJVcDNSNkNhaGt0WXlHdjlQ?=
 =?utf-8?B?VEptMnJJdVBoYkwwODROOVI4ZEZBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA8BD4DC495F314D997B51DBF4208488@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1084fb59-eba4-4a40-bdf9-08d9da93cbc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2022 15:04:16.2349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S4LkJHHtnJ7e4BfztdvadtBxas+6+Lvr34l2/1KqlKaXln8/dGn23Gj+wwlnanCPemBQUSEz9+YOZ1uuhXGd3MH1KaNpCv6X0dhmMX3JPPA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1837
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gMTcvMDEvMjAyMiAwMTozNSwgWm9uZyBMaSB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERv
IG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUg
Y29udGVudCBpcyBzYWZlDQo+IA0KPiBBZGQgZG1hLWNoYW5uZWxzIHByb3BlcnR5LCB0aGVuIHdl
IGNhbiBkZXRlcm1pbmUgaG93IG1hbnkgY2hhbm5lbHMgdGhlcmUNCj4gYnkgZGV2aWNlIHRyZWUu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBab25nIExpIDx6b25nLmxpQHNpZml2ZS5jb20+DQo+IC0t
LQ0KPiAgIGFyY2gvcmlzY3YvYm9vdC9kdHMvbWljcm9jaGlwL21pY3JvY2hpcC1tcGZzLmR0c2kg
fCAxICsNCj4gICBhcmNoL3Jpc2N2L2Jvb3QvZHRzL3NpZml2ZS9mdTU0MC1jMDAwLmR0c2kgICAg
ICAgIHwgMSArDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gDQo+IGRp
ZmYgLS1naXQgYS9hcmNoL3Jpc2N2L2Jvb3QvZHRzL21pY3JvY2hpcC9taWNyb2NoaXAtbXBmcy5k
dHNpIGIvYXJjaC9yaXNjdi9ib290L2R0cy9taWNyb2NoaXAvbWljcm9jaGlwLW1wZnMuZHRzaQ0K
PiBpbmRleCBjOWY2ZDIwNWQyYmEuLjNjNDhmMmQ3YTRhNCAxMDA2NDQNCj4gLS0tIGEvYXJjaC9y
aXNjdi9ib290L2R0cy9taWNyb2NoaXAvbWljcm9jaGlwLW1wZnMuZHRzaQ0KPiArKysgYi9hcmNo
L3Jpc2N2L2Jvb3QvZHRzL21pY3JvY2hpcC9taWNyb2NoaXAtbXBmcy5kdHNpDQo+IEBAIC0xODgs
NiArMTg4LDcgQEAgZG1hQDMwMDAwMDAgew0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgcmVn
ID0gPDB4MCAweDMwMDAwMDAgMHgwIDB4ODAwMD47DQo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICBpbnRlcnJ1cHQtcGFyZW50ID0gPCZwbGljPjsNCj4gICAgICAgICAgICAgICAgICAgICAgICAg
IGludGVycnVwdHMgPSA8MjMgMjQgMjUgMjYgMjcgMjggMjkgMzA+Ow0KPiArICAgICAgICAgICAg
ICAgICAgICAgICBkbWEtY2hhbm5lbHMgPSA8ND47DQo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAjZG1hLWNlbGxzID0gPDE+Ow0KPiAgICAgICAgICAgICAgICAgIH07DQpGb3IgbXBmczogQWNr
ZWQtYnk6IENvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+DQoNCj4gDQo+
IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L2Jvb3QvZHRzL3NpZml2ZS9mdTU0MC1jMDAwLmR0c2kg
Yi9hcmNoL3Jpc2N2L2Jvb3QvZHRzL3NpZml2ZS9mdTU0MC1jMDAwLmR0c2kNCj4gaW5kZXggMDY1
NWI1YzQyMDFkLi4yYmRmZTdmMDZlNGIgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvcmlzY3YvYm9vdC9k
dHMvc2lmaXZlL2Z1NTQwLWMwMDAuZHRzaQ0KPiArKysgYi9hcmNoL3Jpc2N2L2Jvb3QvZHRzL3Np
Zml2ZS9mdTU0MC1jMDAwLmR0c2kNCj4gQEAgLTE3MSw2ICsxNzEsNyBAQCBkbWE6IGRtYUAzMDAw
MDAwIHsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgIHJlZyA9IDwweDAgMHgzMDAwMDAwIDB4
MCAweDgwMDA+Ow0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgaW50ZXJydXB0LXBhcmVudCA9
IDwmcGxpYzA+Ow0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgaW50ZXJydXB0cyA9IDwyMyAy
NCAyNSAyNiAyNyAyOCAyOSAzMD47DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGRtYS1jaGFu
bmVscyA9IDw0PjsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICNkbWEtY2VsbHMgPSA8MT47
DQo+ICAgICAgICAgICAgICAgICAgfTsNCj4gICAgICAgICAgICAgICAgICB1YXJ0MTogc2VyaWFs
QDEwMDExMDAwIHsNCj4gLS0NCj4gMi4zMS4xDQo+IA0KDQo=
