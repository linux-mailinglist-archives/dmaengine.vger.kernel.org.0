Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3425F28FEEB
	for <lists+dmaengine@lfdr.de>; Fri, 16 Oct 2020 09:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404369AbgJPHJS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 16 Oct 2020 03:09:18 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:60727 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404368AbgJPHJR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 16 Oct 2020 03:09:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1602832157; x=1634368157;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=AxXa+fV9zLywgSOxXeHxJyKs+1JMTsu3SkQV2eSy+fE=;
  b=xFhcRM4xq2dxaxTjiTT22AxKH/vvF/Rg60XZCMUKFmwHe5EJH5FRD16b
   cvThBrnX2ex+8vVgJOsUmiGRs8PXys/1gR/in/UkVOyk4QzwdjTy5U6vv
   Y3kYrRN6KLxGztBmauYAm5EqV9jhDiynZNKF4yGLBzNeXf79k16tYHIw1
   QPyv+6mPKMg3yVby7MD7+suqeik53GY9MzU28LGsW7k/VU3TerOliGGNr
   V+Nd1wxq2rwdrVb1qjsh48zLOnqrH/DOhIkz8khQClkp44trd4iaNy6rX
   FC7ZcrwUUtfMJS9xcUWVkyM49VJQqsRM9rqKa0RpZqKnMensw+QnGB2+c
   Q==;
IronPort-SDR: Zrv4EhFQqVb41nXI7A00hSW5NXcfOfVwD9rfZMCHmjnchWFR7PdgkhwgN/fdDbSDiqayiOHiiY
 4mJjsDP8pn820sKPP5UUk6YmNEnKMSPT843inGesIELhK+Mfi7clVBr8QoA49PIaRxmXVoIQj9
 5w11EdrmYjgBlo5rf5XiQDfMh0ByIXdYwjuaSqJLyd+/hRbL5129yDAmZCUmTrhICsHMpZxykt
 5sBvyXu3/mMbQ3ncx1+B4fMIm4Hd8qK0G5oJYNpcY4JwLti4j2kfLFUSE6DZV1OPzgo48BAZz8
 as8=
X-IronPort-AV: E=Sophos;i="5.77,382,1596524400"; 
   d="scan'208";a="99775109"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Oct 2020 00:09:17 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 16 Oct 2020 00:09:14 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Fri, 16 Oct 2020 00:09:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=de5xZfT+NZXLaslG4rS1EdC6vtlfSvKKfySwfTgpFIlumGJa5Mnu0LyN2Miam2x5NDv4DLCwpaSPcH6gdN9utjyohlo5uDcUru0myapTJ7cpe6aPdYcSeGoon2zHtoBitgHr1ujvFHduWLoR5+8w1B7TkgpXsZgEpLKmKWhVjzzng62k4ha0LNpDtlovujFpVV2sf8hdXkswi2/cB/FPy1w918zAW2Tspz8GannW8g11EUipqqcgsyxhOirFqshCRPqPLFhgpEUPllwtnDXt53koon/oFiYk2Ivb4gIAg0BxWYr9TaKXoL1/L5IycTcU6ijDrZkyW7PTUGHz5wJw6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AxXa+fV9zLywgSOxXeHxJyKs+1JMTsu3SkQV2eSy+fE=;
 b=IDeQl3gJPMA/r7Xu96KblooAcmAJoWqZJDG6Hpe+fu78b82bLSkNv1Wvjl3Z9eVTUUdlaHJjerH6BdqMPuiMM8hK++3u5iwveVvQRjcuka6QBbu9rQExLY/HTZTxDecB3+LhGLCijKsE66uEkD0mqJLk8SIzgM9H3zpmdvUiWRd7w+SPtCNPpMoPaNkygUgJATv6lo/zmqnY0+iGAW7cwVYws1M+Gz3vEFFOXjTml0S9qQ9zeXaq1TVhJmB7LHCu/RQzJPEZg6T2u4vR/y+w/CSKWyJGC/v7RBRO8eVm+WaIN8ejhHsAZ/c5Hl63LsgW19HAA4xq0z8fDj+aZyEfmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AxXa+fV9zLywgSOxXeHxJyKs+1JMTsu3SkQV2eSy+fE=;
 b=ApR636VU69vY9yrsL6NVdss/rgTfK72nHgcDq70CRg/bAc3555CcuIaPTXiUR9LHCICOi7hme9fj5jI5yqEO+KHaFOTNvLuWamAQm1fDLDbG0oJE6q1BJhb7DvADPW5LsYCjEtICpbFaTljwJP5va569GgTmGzYlaFOJQ/ozWm4=
Received: from BYAPR11MB2999.namprd11.prod.outlook.com (2603:10b6:a03:90::17)
 by BY5PR11MB4465.namprd11.prod.outlook.com (2603:10b6:a03:1c0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Fri, 16 Oct
 2020 07:09:13 +0000
Received: from BYAPR11MB2999.namprd11.prod.outlook.com
 ([fe80::4854:dda7:8d0f:bb51]) by BYAPR11MB2999.namprd11.prod.outlook.com
 ([fe80::4854:dda7:8d0f:bb51%7]) with mapi id 15.20.3455.030; Fri, 16 Oct 2020
 07:09:13 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <vkoul@kernel.org>
CC:     <robh@kernel.org>, <Tudor.Ambarus@microchip.com>,
        <Ludovic.Desroches@microchip.com>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Nicolas.Ferre@microchip.com>
Subject: Re: [PATCH 6/7] dt-bindings: dmaengine: at_xdmac: add optional
 microchip,m2m property
Thread-Topic: [PATCH 6/7] dt-bindings: dmaengine: at_xdmac: add optional
 microchip,m2m property
Thread-Index: AQHWiqDp9DiavjeRmUuCFfDHAe+8HKl1XEiAgCSebgCAAAW4AIAAAM6A
Date:   Fri, 16 Oct 2020 07:09:12 +0000
Message-ID: <d8a016cb-7f80-c8d2-9711-12377452d420@microchip.com>
References: <20200914140956.221432-1-eugen.hristev@microchip.com>
 <20200914140956.221432-7-eugen.hristev@microchip.com>
 <20200922233327.GA3474555@bogus>
 <6f305564-e91c-794b-0025-de805f1d1a58@microchip.com>
 <20201016070618.GW2968@vkoul-mobl>
In-Reply-To: <20201016070618.GW2968@vkoul-mobl>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [188.27.154.238]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b3d89c5c-33f8-4a96-0e9c-08d871a262e1
x-ms-traffictypediagnostic: BY5PR11MB4465:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB4465265D8209BD9C4D78C2A3E8030@BY5PR11MB4465.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1lKrHVZntGP8HObpfvFJCBXiiLh4GEX8xIQaJQIF+bsQ2ECSgOA5jS7ikIQXcMnfpG06GkWPx4w1g9jF0AAMV3BHaS6Zyp5kiNjyZXeSHdT1LGeN4gFf3sA96EoigIF8mvgoQbEgudsaoMoGjhca6itTXz6rqLYjsezaZvKE72/x2j9308lsIFpaIRj1+FeMg0pEIZ0RayXuXywUTqlQ+coEqbgiweUgzwaUlm5DJMHeuzdeEitvIZEdv6YSKj7sc8oot5J7ge/NtbYkjc8KMemf76ZvErlhT5l2H5/BosWzWgMnOrKxDWuqqTaR51yhJHKfnbicX25Rd/AV/AZmyvyltVcRnOQffDpkUx/UjZoGAa98MJlHDbjsPoPV14I5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(346002)(39860400002)(136003)(376002)(8936002)(107886003)(4326008)(91956017)(83380400001)(71200400001)(66556008)(76116006)(64756008)(66946007)(2906002)(66446008)(66476007)(36756003)(6512007)(31686004)(316002)(478600001)(8676002)(5660300002)(6916009)(186003)(31696002)(86362001)(53546011)(6506007)(6486002)(2616005)(26005)(54906003)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: R5L7BpZo5ErhfClcwzuMjO3kSmPKaSBNdeMyvAsDYeWtilzc80AVK9oJND/RnX0a1kS249WY15wg2SZDJIhvWEbcnvTBqPMO9WHZQiQOlM6gqOsRmWD3I4eSlJyRAFh04AAkv6mKu6dT1M19OaMeYzI7yY9mLJSqL+0uPqvEVJJb1KQs40d2wvQpJVLCDfuYYf0pCwgWmuW0FWysIXJMKaqIi33T35mejJ1qtuvY/STGrXXG+iwOpVfXjYfuAodc5chaFfHyCMmlWT6rgZa0zLdl1TeLCIIiV7d8zMuViH8ZrfA8O5TKkCGlG5SPXyv9V8PC16RmW3N65PJnhMVk4H1wOT6L8BnCoYRqnaqETEy+7iRS38Tmi9avQRAc0jD9NLSGJAuhImZRr90b7kENdutx3aagtLFBKqQIP/PpONbY9Yai4pyXhWn+onIH6wNrrZm+K2i9MqHnr4/1rS3tOlianEjum2q9xFiVlAvDyrbCkn0dzL5ukvvmYhEeahYol90DZjj3/wznVleSaCICRp2vPe1vX8tciRvUmNT25EWH0E2WBLMtOBbBC6bLI5EUGbg6p9fAxDkm2ylRNf0a4x4+rg1ShHnRiqvB9QpmRZYlfauxHFJv/o0hYSmZnbs9CMF6YXBxIPVduqYUJO5MLg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <33A5811EACA98F4FBE73E794131079F1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3d89c5c-33f8-4a96-0e9c-08d871a262e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2020 07:09:12.9342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 62I7VrUoPO2mScsbTYsKiYfS7Pc83XNIyBKQGP0jXN8R7OLsLLA7LuCWn+HvF5Ir3DFiOO8UvH2U34cYdeVt49sXQCCxmMyEWeX1arWz2Ok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4465
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gMTYuMTAuMjAyMCAxMDowNiwgVmlub2QgS291bCB3cm90ZToNCj4gSGkgRXVnZW4sDQo+IA0K
PiBPbiAxNi0xMC0yMCwgMDY6NDUsIEV1Z2VuLkhyaXN0ZXZAbWljcm9jaGlwLmNvbSB3cm90ZToN
Cj4+IE9uIDIzLjA5LjIwMjAgMDI6MzMsIFJvYiBIZXJyaW5nIHdyb3RlOg0KPj4NCj4+PiBPbiBN
b24sIFNlcCAxNCwgMjAyMCBhdCAwNTowOTo1NVBNICswMzAwLCBFdWdlbiBIcmlzdGV2IHdyb3Rl
Og0KPj4+PiBBZGQgb3B0aW9uYWwgbWljcm9jaGlwLG0ybSBwcm9wZXJ0eSB0aGF0IHNwZWNpZmll
cyBpZiBhIGNvbnRyb2xsZXIgaXMNCj4+Pj4gZGVkaWNhdGVkIHRvIG1lbW9yeSB0byBtZW1vcnkg
b3BlcmF0aW9ucyBvbmx5Lg0KPj4+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBFdWdlbiBIcmlzdGV2
IDxldWdlbi5ocmlzdGV2QG1pY3JvY2hpcC5jb20+DQo+Pj4+IC0tLQ0KPj4+PiAgICBEb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZG1hL2F0bWVsLXhkbWEudHh0IHwgNiArKysrKysN
Cj4+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQ0KPj4+Pg0KPj4+PiBkaWZm
IC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2RtYS9hdG1lbC14ZG1h
LnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kbWEvYXRtZWwteGRtYS50
eHQNCj4+Pj4gaW5kZXggNTEwYjdmMjViYTI0Li42NDJkYTZiOTVhMjkgMTAwNjQ0DQo+Pj4+IC0t
LSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kbWEvYXRtZWwteGRtYS50eHQN
Cj4+Pj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2RtYS9hdG1lbC14
ZG1hLnR4dA0KPj4+PiBAQCAtMTUsNiArMTUsMTIgQEAgdGhlIGRtYXMgcHJvcGVydHkgb2YgY2xp
ZW50IGRldmljZXMuDQo+Pj4+ICAgICAgICBpbnRlcmZhY2UgaWRlbnRpZmllciwNCj4+Pj4gICAg
ICAgIC0gYml0IDMwLTI0OiBQRVJJRCwgcGVyaXBoZXJhbCBpZGVudGlmaWVyLg0KPj4+Pg0KPj4+
PiArT3B0aW9uYWwgcHJvcGVydGllczoNCj4+Pj4gKy0gbWljcm9jaGlwLG0ybTogdGhpcyBjb250
cm9sbGVyIGlzIGNvbm5lY3RlZCBvbiBBWEkgb25seSB0byBtZW1vcnkgYW5kIGl0J3MNCj4+Pj4g
KyAgICAgZGVkaWNhdGVkIHRvIG1lbW9yeSB0byBtZW1vcnkgRE1BIG9wZXJhdGlvbnMuIElmIHRo
aXMgb3B0aW9uIGlzDQo+Pj4+ICsgICAgIG1pc3NpbmcsIGl0J3MgYXNzdW1lZCB0aGF0IHRoZSBE
TUEgY29udHJvbGxlciBpcyBjb25uZWN0ZWQgdG8NCj4+Pj4gKyAgICAgcGVyaXBoZXJhbHMsIHRo
dXMgaXQncyBhIHBlcjJtZW0gYW5kIG1lbTJwZXIuDQo+Pj4NCj4+PiBXb3VsZG4ndCAnZG1hLXJl
cXVlc3RzID0gPDA+JyBjb3ZlciB0aGlzIGNhc2U/DQo+Pj4NCj4+PiBSb2INCj4+Pg0KPj4NCj4+
IEhpIFJvYiwNCj4+DQo+PiBJIGRvIG5vdCB0aGluayBzby4gV2l0aCByZXF1ZXN0cyA9IDAsIGl0
IG1lYW5zIHRoYXQgYWN0dWFsbHkgdGhlIERNQQ0KPj4gY29udHJvbGxlciBpcyB1bnVzYWJsZSA/
DQo+PiBTaW5jZSB5b3Ugc3VnZ2VzdCByZXF1ZXN0cyA9IDAsIGl0IG1lYW5zIHRoYXQgaXQgY2Fu
bm90IHRha2UgcmVxdWVzdHMgYXQNCj4+IGFsbCA/DQo+PiBJIGRvIG5vdCBmaW5kIGFub3RoZXIg
ZXhhbXBsZSBpbiBjdXJyZW50IERUIHdpdGggdGhpcyBwcm9wZXJ0eSBzZXQgdG8gemVyby4NCj4g
DQo+IE5vdCByZWFsbHksIGRtYS1yZXF1ZXN0cyBpbXBsaWVzICJyZXF1ZXN0IHNpZ25hbHMgc3Vw
cG9ydGVkIiB3aGljaCBhcmUNCj4gdXNlZCBmb3IgcGVyaXBoZXJhbCBjYXNlcy4gbTJtIGRvZXMg
bm90IG5lZWQgcmVxdWVzdCBzaWduYWxzLCBzbyBpdCBpcw0KPiB2ZXJ5IHJlYXNvbmFibGUgdG8g
Y29uY2x1ZGUgdGhhdCBkbWEtcmVxdWVzdHMgPSA8MD4gd291bGQgaW1wbHkgbm8NCj4gcGVyaXBo
ZXJhbCBzdXBwb3J0IGFuZCBvbmx5IG0ybSBzdXBwb3J0Lg0KDQpUaGFua3MgZm9yIGV4cGxhaW5p
bmcsIEkgd2lsbCBjaGFuZ2UgYWNjb3JkaW5nbHkgdGhlbi4NCg0KRXVnZW4NCg0KPiANCj4gVGhh
bmtzDQo+IC0tDQo+IH5WaW5vZA0KPiANCg0K
