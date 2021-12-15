Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 341D64759EE
	for <lists+dmaengine@lfdr.de>; Wed, 15 Dec 2021 14:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242987AbhLONuM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Dec 2021 08:50:12 -0500
Received: from mail-bn8nam12on2058.outbound.protection.outlook.com ([40.107.237.58]:22977
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237523AbhLONuM (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 15 Dec 2021 08:50:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mux2NKsgyv2V4O4HAeG2kZnv0sl7cTOiIERPzDcGfV7j8+ihrrW6Z7seCgewCdHSERMVjp9f+sMSKDZhdLOSkZ882qZ3XHyh+KjeEJItWY8GUAnFlZz5Cu+Hr3BdSxEYgRez1NVeeIes7kynYZtn0R5rrOxpD63BYUNZpQaaeQGsjYlukHt1aRbQYVpBYowdZs6Zmncp7jqTr3dYldqZZgcNNreIYl4LKN+ndWUdohdk6HWxGy1eBQyr0JwqCHc8pBzEOjrgFAVYBWvHASYE3pVb3ty7KSmjJ7U03vHrgkm1AwtOnZukdc+LCC9l7KxVYWHdyweFI7FVpqPgXFcpEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ZwTnJImsj3zdZw7dns9aBtNOkWG7QNU+Rt468QqmR0=;
 b=LtiqAbPcBo/pIMeWfX7kMyN9HL0jJ+4Lo8b8K9k8ulGVvXy78U5uWRx24d6tpuHsBNLIvmdy+q8lVnYyNZSlbEgZEJK3hlGTiaJ9XqnP5BMm/dFk87UMG/92w/bczqDqG9x3mwDg9detUrZjwDGiKKfTu9oQ+VudEb8Dkdp40VBlbpYhl5w2tsEB0rUcX/CKmtLcV3FN41bzlA1+MOTlIRqcZR0ixgBZnZ2/jibesuNDAfi5nJLQCFQnBd7PHS4zrV7JWh5e4mqX+jTHAdMceDnlO/6j5ECJpA3/uS4f+0q6GGpqZFgOBccYW3QxNTRP6BL/CfKXgNc+qSdWMztuqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ZwTnJImsj3zdZw7dns9aBtNOkWG7QNU+Rt468QqmR0=;
 b=d7Y1gai/2mKPbLW5tXmVUEDNvHOsdu8EPIc8LipibxrkvDMlfbuDQ8MmwuJTzl+xHxiLPWM5s8TqPvPCt7miku9iDX2mGQbUipOfKKaGfYL8FFzGQdENDNNBfoQWBIDuIUCfpnHe7yZDV6ABZyi/iQeIPaz6a8U3Pr8c6y1J46TQAmUoYXKaAbvyFJsYhExjFNLHDE55EfBfSyaLXoH6D5tZhpB263CtrveifaVYKHjngwr1o3wIXpEMHcC1unbGSGpso/bVd1ShBcdbsVSamNYeqGQBMZiwyrYdUtZnM7gDl+XO7EGbQrutpUI3EM8n4nFlURud2qz1lw6a59N9ng==
Received: from BN9PR12MB5273.namprd12.prod.outlook.com (2603:10b6:408:11e::22)
 by BN9PR12MB5227.namprd12.prod.outlook.com (2603:10b6:408:100::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 15 Dec
 2021 13:50:10 +0000
Received: from BN9PR12MB5273.namprd12.prod.outlook.com
 ([fe80::6867:d54e:5040:2167]) by BN9PR12MB5273.namprd12.prod.outlook.com
 ([fe80::6867:d54e:5040:2167%5]) with mapi id 15.20.4801.014; Wed, 15 Dec 2021
 13:50:10 +0000
From:   Akhil R <akhilrajeev@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        Rajesh Gumasta <rgumasta@nvidia.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>
CC:     Pavan Kunapuli <pkunapuli@nvidia.com>
Subject: RE: [PATCH v14 2/4] dmaengine: tegra: Add tegra gpcdma driver
Thread-Topic: [PATCH v14 2/4] dmaengine: tegra: Add tegra gpcdma driver
Thread-Index: AQHX6qFiztAAsdrMxEeFLWzzm9arDqwqsN6AgAjte0A=
Date:   Wed, 15 Dec 2021 13:50:09 +0000
Message-ID: <BN9PR12MB52738F4B5B7494466A9CB5A1C0769@BN9PR12MB5273.namprd12.prod.outlook.com>
References: <1638795639-3681-1-git-send-email-akhilrajeev@nvidia.com>
 <1638795639-3681-3-git-send-email-akhilrajeev@nvidia.com>
 <3f7b072d-f108-ebce-e862-eff9869d1d92@gmail.com>
In-Reply-To: <3f7b072d-f108-ebce-e862-eff9869d1d92@gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5ce7934e-27e2-4c3d-0230-08d9bfd1cf8c
x-ms-traffictypediagnostic: BN9PR12MB5227:EE_
x-microsoft-antispam-prvs: <BN9PR12MB52273846B214D389F6FDE6BBC0769@BN9PR12MB5227.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eIAHd6c9YLVBa6XyA1WGHXJgmSnFjRLEmSUnW9ruUCKbe+BU1rIFaTo4+qiPodkfvz/GJb+DgUP9Jl/dYdex9y0cjIXbHzhAiAwPjJbrka544QRJD8YUIYxqHau8QJ5AZIBjKsQIVBkgB4WusXo3yK8prA0OZSwqO+5nZGpqpxs7HwTj9284JdLhhfbzyJjloFiKFD+761sPK6ssaBUM2gY+5ibRqyhkTeqbojxk/gDdZ6RNLz/n1Zbbz9z5T00yES+G4Of99nMYPTfIGv6TY5wDgtWYSliCTmaeA+WLp83Dr7s62mHY1TuAxMEvIP7hfvCGXAvsClyxLw+Z28/LXHSkHPBDP+AUDd6YTNcX9iw5s0wLfQ7Ip94tDQVE2YTABQkpbnxEz938ngw4Y6s/7Lsm4NXtqe94jg+79LZfHB28bvEl0le+AADpDQuG5WRpvhPSFdkPQ8i/BUUrcKAbe0gjUBXYuC8XmZOMYPV67RXjHikNsZTdk4B+eeMQzr91lb182B6ksTGYm+8rhn1UIKfYoBpZIevNPnOMBbybrRulWtzYmIFx1jNGssifnawrswp68sZqSA+9ClKJ31xm+1sd2O+tb1aRXfu1lBk1AXkODJgdukP92t6h4NW2b3VQcURa6/i6/fncQPAAAes/sD7/btOqmbnFNlw5siXanqRsju47+SuWlDMG1UwG4VcQIpc2+znoeR8M02lIjlYqkI6d3TVzKArtVPfhtWKDDBU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5273.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(52536014)(2906002)(6506007)(66446008)(508600001)(83380400001)(8676002)(66556008)(8936002)(316002)(110136005)(5660300002)(122000001)(186003)(33656002)(66476007)(76116006)(4326008)(7696005)(9686003)(4744005)(107886003)(86362001)(55016003)(66946007)(38070700005)(55236004)(7416002)(64756008)(71200400001)(38100700002)(921005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0xIZUlHNnM5ZDFpZXJyRE1UMzM4SjRZQXRIQVhaU2FNOVJxTGluSkF5MEla?=
 =?utf-8?B?UlpIV3JXUXBUcHpjSkV6aHNKY3lUZ2hDOEkycW5ydDdPOE1jWGlOM0RHeVEw?=
 =?utf-8?B?aUxHRHUwVlArYWVwd25jSk85QkhWeEptbUNCTXQ1L2I3UmZwdFRadkczZkNm?=
 =?utf-8?B?cnlMWmdsc3NISGFxTkVFb0doV0RtNjQ2bTFnbGg4M0xjSThKSU5VWFpoUEtq?=
 =?utf-8?B?Ukd6SFk1L05BMmVaMFp3ZDNsUHpFcVNBVjkzSFJnVWJJTVFZZjl6dFI4NW54?=
 =?utf-8?B?VkpUYVdmbTc1NlArNzNSL2xnMWhKbHp4QXdYdlhCd1FOU1lvSkZKSlNaTlcr?=
 =?utf-8?B?YXdFNzVDUHJBSWxSaW10ZWlMK01tWW5TczdaSWVVTWh1Mjc5L0NabWoyRVQz?=
 =?utf-8?B?SnY3NVZRY2xTVUlkUHBscFlwenExWTB5ZXVvL0U1N2lVZzNwbGN2RXlsK0hH?=
 =?utf-8?B?SnBXRVdXdmwxMUhraFNvRXFRVjhjYi84TEhMV2RXbmdFNUxFODhCUWtWODN3?=
 =?utf-8?B?ZjUyM1ZmanJsUjc1RDNQM2ZQUnl0Z0xxS2FNWGxWY3hpNFhLSXdTRERzS2lk?=
 =?utf-8?B?SXpzQlRYSzFJc3pMd21nUnNsNC9tN2tzK3pGK3pVbkNjNUY3K1hQYndQWkRw?=
 =?utf-8?B?b1JlbFM1a21aNjZja1ppSEZHR0Zzd2VJTWhjZWMzYWZLSnBpY3JsNE5idWo1?=
 =?utf-8?B?S3ErMXBpV0V3eW9lRDVhR2lkZnZiNTZQUkxGMzQ4bGhZZ0JNYUJwSEVXZHNP?=
 =?utf-8?B?VTczSjNiMTZ4SVZuSzBMY3ZTWWFheDFYVThmRk1FWE1qLzVkYVNQWFduRXRX?=
 =?utf-8?B?ZWtTaEttMGxQSEs2S0RSWmNSbFQ0eWtFbGxSdEpIbnI5L0JGa1FhTGcvNUlM?=
 =?utf-8?B?NHliaFQxZ0poSFp4YnRYSndLVmZIeDFndnJKMXZkYkcxbzcwU3NjTmlueUNS?=
 =?utf-8?B?MWQzcjExcnA2SnJhUFFuRkE4NmtuelY4dmJIejdJcVFzSkNJdDhqNENpZUhE?=
 =?utf-8?B?NVRpRDJXeWEzdVZRcVY3RmZLRitwWTl6UUs4bjEza0diY1ZKd1FyQ090OUkz?=
 =?utf-8?B?M01nZTM2TFVuTkwvZ3pLZW1KeXVULytaV2NsaVlYZThBSnJpT2ZiamVZY2lt?=
 =?utf-8?B?WkVwWVlJUEREa0M4d0RUdGhpRlRGOGdoQnRCN2xYcmJoWVM0QmhoeHJ1Rk9k?=
 =?utf-8?B?TFhnSkhFc2ViZ2cycjBzdGxiMitXQ1cwbW10ZkhUcHUvdUNUQk1aYlVEc1BL?=
 =?utf-8?B?NytLMnFvcG1IWWFLajRvTFNicU1EWVN4STBTOXRFZ3RPK1p5UVphUUZHOXE0?=
 =?utf-8?B?VDl4VnQrNXlqVDRzRkhzY0pxT3YwS1VzL2RoOGRhR1MwTmg1MzRnOXlmbGg5?=
 =?utf-8?B?S3dVQVRVUklPczFiazVZVHg5ZkRiOTFhM2xqU1ZRTzdiaDFCWHkvT3pzdGZr?=
 =?utf-8?B?RUpsTlpwK2lOcWRFaG50QjhOaXBjVFg3THBRUmhlU1l5dURNaElhNEVPV0h5?=
 =?utf-8?B?eTQzWVF0R28yU1AvMVM4WktUU213SW1yNm81ZUtrYWhKMlNkZCswMkx4a20y?=
 =?utf-8?B?WU5vQndDYS9Qc3d6TlRONUxDTU9sYmVEQ1duM3Z6VWswRXZ4NmdwdjZjMmth?=
 =?utf-8?B?Zk85ekdlaHJJS3VwZ3ZDTEFCTTUrdGE5cTBEZ3lvRU16Z254TjBwUlNOV01a?=
 =?utf-8?B?VHpaV0toMWlLTGdlSGNKb3drYW1PNDdKbW1hWnhnbXZQODdUUVArb00rNTEr?=
 =?utf-8?B?MitWNHROT2RGSW9yL3dkMGJLVW1NNDZWc2krUU4rTHN5cWFBYVZVb0lYQ2F5?=
 =?utf-8?B?b2dRQjFHQ0JhOWw3N29RWjB3UXNLUy8zd2VFRUszL2hBam9tazlTYzRldWR6?=
 =?utf-8?B?b1NFSXo0VWdqRkhtUUtaZExKOFZ1WDk1UmxxU0dMZzBodVpQMk9BRTNZK25C?=
 =?utf-8?B?aFN0WWhRT251dlFKcGdCRUltRjR1cWErOXQ3QUZROWNqczhvL3d6QysvaG40?=
 =?utf-8?B?eDJVN05iaFl5SEU2THVqdmZFY3V5K05nc0E1ckJUK2dzeUV0cVlsTEkwUVpk?=
 =?utf-8?B?WjB1MlprSHJZZFJnYWZZWmJCYm5zTEVLejR6eWoyOW5aR2xzaTM2VkZIbElY?=
 =?utf-8?B?RmY2cENCbzdMaSt6Ym5UbmRnOXFkcWRjSG42V3Ezc1JyOS9mQndQRFFLeitq?=
 =?utf-8?Q?8w3L/N0OfRL6Q+DXgXpyKPo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5273.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ce7934e-27e2-4c3d-0230-08d9bfd1cf8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2021 13:50:09.8744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YZqfJX+FbEt/QX0smerh4KwzIHPplfW6fZrjjCSMEQ/E4FBP1nGtnZRvgkn6CQMzpbPV6jO1IBKs1qQN9+U/fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5227
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

PiAwNi4xMi4yMDIxIDE2OjAwLCBBa2hpbCBSINC/0LjRiNC10YI6DQo+ID4gK3N0YXRpYyBjb25z
dCBzdHJ1Y3QgX19tYXliZV91bnVzZWQgZGV2X3BtX29wcyB0ZWdyYV9kbWFfZGV2X3BtX29wcyA9
DQo+IHsNCj4gPiArICAgICBTRVRfTEFURV9TWVNURU1fU0xFRVBfUE1fT1BTKHRlZ3JhX2RtYV9w
bV9zdXNwZW5kLA0KPiA+ICt0ZWdyYV9kbWFfcG1fcmVzdW1lKSB9Ow0KPiANCj4gV2h5IGxhdGU/
DQpUbyB3YWl0IGZvciB0aGUgZHJpdmVycyB1c2luZyB0aGUgZG1hIHRvIGJlIHN1c3BlbmRlZCBz
byB0aGF0IHRoZXkNCmRvbid0IGtlZXAgdGhlIGRtYSBidXN5Lg0KQWdyZWUgd2l0aCB0aGUgb3Ro
ZXIgY29tbWVudHMuDQoNClRoYW5rcywNCkFraGlsDQo=
