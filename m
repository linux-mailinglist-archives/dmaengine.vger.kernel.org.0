Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F86F47CFB5
	for <lists+dmaengine@lfdr.de>; Wed, 22 Dec 2021 11:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244075AbhLVKIU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Dec 2021 05:08:20 -0500
Received: from mail-os0jpn01on2114.outbound.protection.outlook.com ([40.107.113.114]:56961
        "EHLO JPN01-OS0-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231968AbhLVKIT (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 22 Dec 2021 05:08:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gdtTsgsAeCP7LM6+Nb/eRJzVi9f8NjopkfyifAASU96vCUHhmpLnOsPtsS0nrjPP8WafME6q7FfHdH20a3zJcIZZQJm6Ne6v19CJqFoAP1BRhR45+1HbUGlE8txHsagbQ+ZStxQLGtVSv0fnze3B8hIGStG+5YPI2ZrIYCVSt0UaCkVxgCJNfw5/ZAhrToW6yapyHGvayfrNttdNyJ2irNn7+gZEAA9USVXWHbU0IC3nrqFlKIxPZJl11KwHNRExAe0DlzR27SLA+RyfRKTOsS3bUlDFmDG8B6C3Ox4NUli+dqYsYo3M97l7u/cw9XzteSPdqnNW5cuDGeAp3wjD5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/17NvgsnGElRtSuNCrSUky6CQcCnlHbYd4J3Vt/5/1k=;
 b=Rv7ts/+ubWqwCbIgu5+tsZZ6w5JVNg5tKNw0sIEqwuHk3SPt2JSUPWcjON+memzVm5hbdh26+cWocYYbmUm6d0AZNp/dCHRM3IJcrpBWG6u92RxC3wQZP8ODJJmQDsgr08aWs5XlRF+JK3Fh40sce2Bt7zEEEwNZBDkIfIBuDSfJnh7efr6qubtGYsCNaEmvQLb5x8/0ZobiNkq6YQdsSkTrJb9rVAgJBxwp2EbbXn0kPr3QALLs+sRlclEtQ3Ih5NkEtbK3VOUS9VQ7Q+MGT2SUUgk8+9FJgK7mRTFqW6k72lUSe4bYwswlMpEaiFOYTDpfgiLLhcUeI0vpwaGjug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/17NvgsnGElRtSuNCrSUky6CQcCnlHbYd4J3Vt/5/1k=;
 b=PtJsrl3J8bZnQCrDK105a7hK6msbd+O6EiFAxdc3ZBTryZsaWbNNFQxit6zMhTr20TIDUe5n1rZHPz5f9cgNleXjgLAcYF+WF7qq9WBjNP54ebgdfhr8U+6nIDgKGoLF6dggddMAHtz16WjlzdXaWuIFA9lgZi0/Ej6gboDgGog=
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com (2603:1096:404:d5::22)
 by TY2PR01MB3290.jpnprd01.prod.outlook.com (2603:1096:404:7b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.15; Wed, 22 Dec
 2021 10:08:17 +0000
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::b0dd:ed1e:5cfc:f408]) by TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::b0dd:ed1e:5cfc:f408%3]) with mapi id 15.20.4801.020; Wed, 22 Dec 2021
 10:08:17 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Vinod <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 1/3] dt-bindings: renesas,rcar-dmac: Add r8a779f0 support
Thread-Topic: [PATCH 1/3] dt-bindings: renesas,rcar-dmac: Add r8a779f0 support
Thread-Index: AQHX9it3FUWcsLyHuEOa20bLykFJtqw+O96AgAAKGSA=
Date:   Wed, 22 Dec 2021 10:08:16 +0000
Message-ID: <TY2PR01MB3692B4F09902D9B39FC925FAD87D9@TY2PR01MB3692.jpnprd01.prod.outlook.com>
References: <20211221052722.597407-1-yoshihiro.shimoda.uh@renesas.com>
 <20211221052722.597407-2-yoshihiro.shimoda.uh@renesas.com>
 <CAMuHMdWS+6wdN+3eE-A3EF74-SsY4bZrFZ+8-Now78H0U+fG1g@mail.gmail.com>
In-Reply-To: <CAMuHMdWS+6wdN+3eE-A3EF74-SsY4bZrFZ+8-Now78H0U+fG1g@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f2fdbf0f-b24d-48a8-f414-08d9c532f943
x-ms-traffictypediagnostic: TY2PR01MB3290:EE_
x-microsoft-antispam-prvs: <TY2PR01MB3290DD3C5DBB25C42FA268EAD87D9@TY2PR01MB3290.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LIzHhYD0yXmzjdBvLBxuT2r7tCbtYvd7JO0yXKH6+O3/qEmnLLni9S4vOMDa9uO6f0D7xU0XqjrVhWyDp5cNJmvdGjaDzigUIRdjLOyji11tacnaWa6/ez3dFkxszbUf3r5ZS1y0C7dMvhPMtrztTFZ5HL37ZSMpZesJI64d+MytyJLOSaDhQmSxczM/3cwxrSpecHwQWzyr1OqhbCGjzJXjV2gDk1Ez5SVv9DEJpI+HgdkDYgDfuk0AdJ0FZCCPDVKg7ey5K5Wzo/cYFDpxBdCJKDZHx90Y7yDvz84sK9zqYrwCf6tyg1O/W2LtkW1ycjWkcNG9hePM2EaZWTayLZFluOoh8wbJYd8h5HSvkEYo+ADaHOoGA4f8FzyLjKKLURakInd/0nEEjToqu9JHJcuhLd5JkghShdG1GhSj1pU4nPSaOU6Z7CpJHZ0BnVC+N89ce5W3Pp3xcqgqZwHW4BZQZPth+eXy1n7CU7x/Nk1g7vzbJ+7Ytoq4DwGX6wEzJP0IkXGar+Jvxznx/AspZ0V46oZF4gbjg8th6/yOfdH19nJHjDU2jL0GayNatkT8YW58Ss3HSD9ntjcxBGjlIIDCqBhndYmO5+EQeRgjqgd8+GP6pMeCTOYiqg6v3uV/TylfjCTvyLvKSWOdAMbE8iFVLAuM+rMzb+nU0U2/8w9Ymdz6NEr65LzTWFNBwDOCcqUwtydQHYPexsdhLZUUAw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3692.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(66946007)(66556008)(71200400001)(9686003)(55016003)(4744005)(4326008)(83380400001)(66446008)(5660300002)(76116006)(52536014)(53546011)(6506007)(8676002)(7696005)(64756008)(186003)(316002)(2906002)(6916009)(38100700002)(508600001)(54906003)(33656002)(122000001)(86362001)(38070700005)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c3lNRjNwUVNBeStLUGlBOTdzck1JdEJxaVg1NlVsMTJsaENQWk16OERrbExI?=
 =?utf-8?B?RHJzSGJhY2R3WjRySVFET1hxdVVIcEpzZVp1L213dmJQTnU3QjZMcnRIWkl2?=
 =?utf-8?B?Umhpd0ZORzgrTmxpZ2M4UUtzMlgxcVpDQzl1NU5wTCtlM1F0d0RweEpEM1Ey?=
 =?utf-8?B?MHhvUWJIdGU1YTFsa1hNbDFRRVdHa0UzOTRjaW9uWG5rcWI4ZTN6b1Q4cVJr?=
 =?utf-8?B?VjRMR1dIU3htYnplM0VTZGEyVkd1M084TGhTc04vQ2NIR3laZWpVUFF6OG1O?=
 =?utf-8?B?emxpUS9qUXN3KzNlQUgzUG1mZTZ3blJDNlNLU3o2eDBFWVlwQzJFc2JkNjYw?=
 =?utf-8?B?N1B2bFh0ZHJZWFpFZzI5aWdZTUtPUVFKa1F0MWlXY3RlcUZ4RUFBeGluTVVK?=
 =?utf-8?B?Z3JLZS9pdkFQRnJvK3lmRlF2MzN6S0hQMGNsR1R6a2JydjZnZ3I0TzRZZndy?=
 =?utf-8?B?OXlFQ2NZMnorRGdEZldTVUZ5Y3F5U3gzWHRRM3ZjZHN0bHJoQW5NMnBQTVF5?=
 =?utf-8?B?dnlPVjN6WHZib3hrUG9oQmZQZGdrd1V2MWtLSEhJRm02emFrNlloazR2Mlds?=
 =?utf-8?B?bTkvRFEvOGVZL1ZsTkZkcU43SVgwazRiYTFjemV0OGdqRTBydUJrb1BJb0Rm?=
 =?utf-8?B?dTFJN2F1ZVg2bTg3ZkhsdUo0YzZxdVJUYXlvSVNHWlU5aXpBOGRrTE1sVEl2?=
 =?utf-8?B?QWFOdGRuNmdHZ2VYdDV5TnpUOTZ0eXM4QUkrZFBtb3BTTVBYRFhVbW0wQ1pz?=
 =?utf-8?B?ejQ5QmM4eUs1ZmZRR1ByTGhDSVV4bTJsMTMvQ0Z6NnNRUDN0U2FPNGtsa1lQ?=
 =?utf-8?B?Z25iNWVvcThnakRkQ2pSUXVjWldmYkYybmxZQ2dpcFFERjlKajBGVXNaNEFL?=
 =?utf-8?B?cWdHNUh1Y2VSdi8xVWpPSHplcGlCeXNlOGVYdjRoV2JlNHdoVEFseDZUVkpH?=
 =?utf-8?B?RVVsdU1PclNtSXFUWk5yREVObGdqWVNTMDZTQTVPYlpKeWVEc09qcVA2QWlF?=
 =?utf-8?B?UFVhVVhSVU5Yb0ptL1dHZkI0a1FiZzRuSHk3NXZNbU1sZWFJVWlZaFpRU1N4?=
 =?utf-8?B?Z2p6N01EQmRnNG5BcXpjanNKUUlCaFRMVFpySnBUdE8xaUgzczg2SUpOVHB3?=
 =?utf-8?B?OHllT2k3RFI1MmVSaUU5a1lPTUJiT3JrdVdVWkVpcURWTWszd0k4Rm9OWHY2?=
 =?utf-8?B?NW4zSk1XRlpwVENiTWExRlBKRnV4WGtrNDMrSkU0SXJZVVN6SkVXQ00zZFdm?=
 =?utf-8?B?RTNhejVlc3dCOW9wZU9ROU56anFMY3lwSEk3dHh6b2xld09xMTJzdmcxaVgx?=
 =?utf-8?B?UFovYWtXams3RURoT1EwVExvczlTekZzaUJvRlpoYk5KRVg4MWtHcU5YcHBQ?=
 =?utf-8?B?R2pWb3JkMXBzcUV5WVNlaGpuMUtZbVNBdFRXeC9jYWM5Z3YvK1VLU2V1cmxJ?=
 =?utf-8?B?bFZzaU5ZVmNkdGZtWkVjUXZMWHRneFYrcDN1Um9BTGhWMk83Q25tMHNLK0dM?=
 =?utf-8?B?ZkVISjVSVlBJNTRPNXRIWk83SlNncldnSVpjMlpLRDlxazFMWEd1bGJ6NDVx?=
 =?utf-8?B?QU0vUk1UU2Z2VnRBTDd6RVFzL0V6YXV1QlBTd2RoNlNzUmgyOGFvSVhsUVJv?=
 =?utf-8?B?dWgzNmZsLzA0cE9yQlVYT2htS0RmaUEvUW02N0NWaVY1WndmUWk5VzRRTGtj?=
 =?utf-8?B?bUhnajFvM3JZalJ6QXVMSG8rdXFpSkZqQlJzMmYrM2NyNWxWZFI0VTZGUXk4?=
 =?utf-8?B?TmhFd0VBQVR4aEtnakNubjF5MHhQMVpYSjZpSUU1RW1iczlkYkExZy8yQkZo?=
 =?utf-8?B?bWxHVU5SaEJtVmFrTHJqai9aU0xGZytva3p0OERGb2VVRmdqcmdJY2crRU83?=
 =?utf-8?B?ZWpNQ3JnY2ROeSs4TDNZcXloSGhXMEVtY1hnUG9tODNBVytRMEZiU3FmS2ZV?=
 =?utf-8?B?UlZ4WXdjY0Y0YlkrcGkrRWF6SHdnTW1FSEkvZy9MR3lUa2pDOUVnRmwvT0pT?=
 =?utf-8?B?OG93b3o4Y2FidUk2Umc1L1g5RjVIY1NVN0tHWUliNWRmQmZCTWVNSUJrU2l3?=
 =?utf-8?B?WWZGZjcxcko5UDEvd1dsVzI4MEs2MEwyQUlScWNkQ2E1QkU4aVdSaEc3UHB0?=
 =?utf-8?B?MklISnNSSEtFVzBjS3FJc2Y0UzVvRk4yNkhCZlpsd0ptdjlKOEYrZHZuZmsy?=
 =?utf-8?B?cGdGdjRIWTZHQ1pRcUxoZ1RBOW5CZzdBVzRjdUQyUGtzTXY5Z0dsSGg0Rkgz?=
 =?utf-8?B?NmpYM3BIL1NOeXJacE1rNnExcXJFMXo1WlJINFVic2VLTWQvSlhySk1qd1FQ?=
 =?utf-8?B?dEFJNDZKVWZ6SVhFL0ptNHdGWjdFNlNwN3NMSDROUEcvTnQ0Tlh1YmZUWUJw?=
 =?utf-8?Q?XZizFyTsIJVc/gXLEwvb3Mci/HmbFLe1qIE9p?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3692.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2fdbf0f-b24d-48a8-f414-08d9c532f943
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2021 10:08:16.9453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z6uAzKljqN9RMx7TfPxFzL/ogtdCukZ/9CTYJKocSkFzvXzxjUx29x9Ak5ADQ8CeAF3eOlzLd78svZPUSwjozMTgkEpEO0x6gdrFngbf0Eb4q/1MscyjdjLBBzPkjLKf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3290
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

SGkgR2VlcnQtc2FuLA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgcmV2aWV3IQ0KDQo+IEZyb206IEdl
ZXJ0IFV5dHRlcmhvZXZlbiwgU2VudDogV2VkbmVzZGF5LCBEZWNlbWJlciAyMiwgMjAyMSA2OjEz
IFBNDQo+IA0KPiBIaSBTaGltb2RhLXNhbiwNCj4gDQo+IFRoYW5rcyBmb3IgeW91ciBwYXRjaCEN
Cj4gDQo+IE9uIFR1ZSwgRGVjIDIxLCAyMDIxIGF0IDEwOjUwIEFNIFlvc2hpaGlybyBTaGltb2Rh
IDx5b3NoaWhpcm8uc2hpbW9kYS51aEByZW5lc2FzLmNvbT4gd3JvdGU6DQo+ID4gRG9jdW1lbnQg
dGhlIGNvbXBhdGlibGUgdmFsdWUgZm9yIHRoZSBEaXJlY3QgTWVtb3J5IEFjY2VzcyBDb250cm9s
bGVyDQo+ID4gYmxvY2tzIGluIHRoZSBSZW5lc2FzIFItQ2FyIFM0LTggKFI4QTc3OUYwKSBTb0Mu
DQo+ID4NCj4gPiBUaGUgbW9zdCB2aXNpYmxlIGRpZmZlcmVuY2Ugd2l0aCBETUFDIGJsb2NrcyBv
biBvdGhlciBSLUNhciBTb0NzDQo+ID4gKGV4Y2VwdCBSOEE3NzlGMCkgaXMgdGhlIG1vdmUgb2Yg
dGhlIHBlci1jaGFubmVsIHJlZ2lzdGVycyB0bw0KPiANCj4gUjhBNzc5QTAuDQoNCk9vcHMuIEkn
bGwgZml4IGl0IG9uIHYyLg0KDQo+ID4gYSBzZXBhcmF0ZSByZWdpc3RlciBibG9jay4NCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IFlvc2hpaGlybyBTaGltb2RhIDx5b3NoaWhpcm8uc2hpbW9kYS51
aEByZW5lc2FzLmNvbT4NCj4gDQo+IFJldmlld2VkLWJ5OiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdl
ZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlPg0KDQpUaGFua3MhDQoNCkJlc3QgcmVnYXJkcywNCllvc2hp
aGlybyBTaGltb2RhDQoNCg==
