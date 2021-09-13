Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 967F2408350
	for <lists+dmaengine@lfdr.de>; Mon, 13 Sep 2021 06:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbhIMEJz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Sep 2021 00:09:55 -0400
Received: from mail-co1nam11on2051.outbound.protection.outlook.com ([40.107.220.51]:14596
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229563AbhIMEJz (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 13 Sep 2021 00:09:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJb1luOM6mor1ly4iWGbM88ssVakaf/FGZPodUgIWIC223H2a4GpCU3+6jSXv4Go0n31D1a6nIw5isfMLZvhkuA5vtO1RGxKaJ1g3yDtbbYG4614T4/iLlnnKAdVB5bn1qlTxbQ+wuwNyMmjXYGlEzUVPtrlkJ9PxYB68jKgGvxisW1D5LTHLKUtB6QvRMUMeOYyhU3xkIdG/Q1swls04R/ODP959qZZ2nd+cb4cHUplLXqkVbF8yLuudMZGt6Gq/YzlNX/zoEiStMibfNX19XwNJ+f90u59AFoY97pT2YIu7tgmj+BNVTNECUoT1y+2m1kHnHcivGqcDpUQzY2Nhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=GHr5wp9KuZlxJqVcfZ0FVCUnUfBmuOBOtbBT3MHDuis=;
 b=aOPoGNUy/3UowmbIAgGvh/lTDtcFFnQZE++YWEbiHM1n9sP5MnugevYxPZc2dGCyNOx5ibUvo3X35iVhJhrMYp0PIBvsv+tVilbWG5UC3cJpNDbxhgw0yMhf2agJuumCmoITyxnOlWVRkoUaE0sgyOuE4SinFHIlL+5FEFnviklyx3jbFD6Z5ZuXlNNbfeRncjvedJxVNYhijWvr412b+3NHm7ytjC/WjnzwBt8Z3RvctddVMeuWPEDK1j8vZt1p1ZlprSTDUA9XKYU8mkTMuCSGfntEljP7VcwBHsZTNiXHY4OgM9IGKxnocuT8slVoUL8e+D78J3mLIAGKjeE9sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHr5wp9KuZlxJqVcfZ0FVCUnUfBmuOBOtbBT3MHDuis=;
 b=TP80qfPJBPkqK2wEX2IWQAkDdm9XeNrY+ez0Ek2jg4QM/t2p5pMzMLkZzMb0tQAfep9Nh+ZI1gEF4Q8RkwIiLu2SD+NJpfF/oVV/L8eiTkaa8w/Lmu3oazLt+DskH1wBN52s12+OTGVMGj339GHd78501wQzqJkZmmuml0f3Zp9XcL1jru9DfFo7LnWL8Xkmjv2JFMqMMPQKVme728aL9jMX7R9lLGSwwLsd5rwdpcbiHefzw5TkqRU0/u8LstpetgBAz7hl5CKe2H++G5sZAYg13+bFeQfpLorPGiolzUZYRJp6hJUIhVkxlxj3YTmksWL4vB0HpN7YkKaKop/oUg==
Received: from BN9PR12MB5273.namprd12.prod.outlook.com (2603:10b6:408:11e::22)
 by BN9PR12MB5193.namprd12.prod.outlook.com (2603:10b6:408:11a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Mon, 13 Sep
 2021 04:08:38 +0000
Received: from BN9PR12MB5273.namprd12.prod.outlook.com
 ([fe80::b54f:5a6c:caf8:7445]) by BN9PR12MB5273.namprd12.prod.outlook.com
 ([fe80::b54f:5a6c:caf8:7445%3]) with mapi id 15.20.4500.018; Mon, 13 Sep 2021
 04:08:38 +0000
From:   Akhil R <akhilrajeev@nvidia.com>
To:     Jonathan Hunter <jonathanh@nvidia.com>
CC:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        Rajesh Gumasta <rgumasta@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>
Subject: RE: [PATCH v4 0/4] Add Nvidia Tegra GPC-DMA driver
Thread-Topic: [PATCH v4 0/4] Add Nvidia Tegra GPC-DMA driver
Thread-Index: AQHXpL5bVT7HzQ/p6k+8gpwSO/kO/KuaWCmAgAcHUeA=
Date:   Mon, 13 Sep 2021 04:08:38 +0000
Message-ID: <BN9PR12MB527310DDAAB7F703CD7CD126C0D99@BN9PR12MB5273.namprd12.prod.outlook.com>
References: <1630044294-21169-1-git-send-email-akhilrajeev@nvidia.com>
 <1631111538-31467-1-git-send-email-akhilrajeev@nvidia.com>
 <8525e868-30c2-017d-0feb-fc0e8f344da9@nvidia.com>
In-Reply-To: <8525e868-30c2-017d-0feb-fc0e8f344da9@nvidia.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 030193ce-0821-4836-ce79-08d9766c2a38
x-ms-traffictypediagnostic: BN9PR12MB5193:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB51938179B720FDA6AF060336C0D99@BN9PR12MB5193.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3N0eRtC2CS7EKLgKkVp5uX7yrWue0CalIq2LP/FWwrHqVONy/hJhnk+6qCHEKqArNDseaYw8jE+UcR1a5AQPLqYOg4ycmtsm+sequtsgG4+pVf/KU8+N86e5joqFrnL4tv/yVdWcxlccMULIHBmlOI7Xqc8xoty045AkrtimeGjb7cdjAfqcDt8z4Ze4XSek290mktVKuH+DaY9AnTvzdeooRcIA6u8y87bMFDEY9H9W9li1EQ8BFVvi5zDyUSnzmCcLVEFc1MuhcslHB+F1Np5U1raljUXvu1vdR7dugFJVNu+TcDg3oNtX5gzvElz0LeWn1iXWyyXeTV/3OlpeN4dXD2HR/R5TTxA2Zcr/a2zgYlrA88uRi7n1Ppql9Wwvty0sIsj+BimdCPzz5sjkSuDfuwBYo/NnTL+4Krz2mRQ0taO/qgtNGXms8J3YOTCzdDmlRsPu9ondaDqxvTMKgxHkSj4MlC67Hu+OylDP0X6Gqyk9L9M+Cd9F9PkISwxmJoXzgkIc834a3FZad6hjIgvCEJOrNfxJDvhNT/E+hxbxcYiSvJosyGJgh7t1SRDhKMXjwhU16nMiC40c9TEsBOx8CR7imMrgGMHAdwkZ/3UpH1womhuYN/dWiA/mPGbs1FgxEpK1vxkUnpZ8HNWTUjKMX05aFlliTFpt81EOdiAwujYL59gTAEuVJz1Ywq1mPBW+FWWQWYrFTKeQEo6DWQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5273.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(316002)(6636002)(86362001)(2906002)(66446008)(64756008)(478600001)(54906003)(8936002)(33656002)(6506007)(8676002)(7696005)(186003)(5660300002)(4744005)(38070700005)(6862004)(66476007)(76116006)(9686003)(66946007)(66556008)(122000001)(4326008)(38100700002)(52536014)(55016002)(26005)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RFRtMjVtNGsvbHROOC9HYzhqbGNFQlNVdlMrZDNJSnVFK0pJOXJSMFg5eU5n?=
 =?utf-8?B?R0lnQmhSak94Qk5NRHZWZEpra3FaRjB3T05MVERYczI1aTNIUHh2djYxLzZp?=
 =?utf-8?B?Qit6NG01bUNBc204K1BkZVg2ZGxhOGF0bjhUYnIyRU4rZENSc3QxVUxwVkt1?=
 =?utf-8?B?NXV0TzYvaUZxYVhjUXFoR0pPTXB2VWNSOWp1MGNnVGdQeGxRMjF5aDJUd2dO?=
 =?utf-8?B?RURLbFJYTDI0Qjg4U3E2WWZZYnhwaDQwazNXK25Rc1hrNXVYNmwvdFFZNDh0?=
 =?utf-8?B?QktJTHhaM3ZGdnp2aHlzNEdlT3R5Tm9qQTJqMFFLNitNOUc0Wms0OUV2eDVN?=
 =?utf-8?B?TXBOWWxUR2I1TUcxTzBLbHFBTEk3VWhNWGY3KzNrb29iL2l5OFRVTzdKL2JW?=
 =?utf-8?B?OW8rUVIwdzN0UVBJS1BubnYxSGwrVkhETW1qbFlXS3o0NEU3NWdaUE5yVnRS?=
 =?utf-8?B?UkxEYnp5VnJRL3Bha0c4RHZmUllmeEZUbVFDTWhYcG1vcy82c1RpNGZUZFpS?=
 =?utf-8?B?VS9MYTB2d0FMMzdEWUw0VlJjcWxiTkNTcXdwdDZkTHJBS0wwdk82ZVdPVWVT?=
 =?utf-8?B?UjNid29leUV6MnFoeERydTB4UEU2ckdwTEhXMW9qVDFDYXJkYnhjYWtaYWt0?=
 =?utf-8?B?NythWFE5NVEweTdXMUxYSVl0U1N3YkdyejhDOFFEaUdWZmJ5bCt4MnV4Z0JK?=
 =?utf-8?B?RHhSS3dqNkoxWGFZdktrQ0RER3BOZkY3ckJQOExrUmszZFFYdWZ4NEttL1lW?=
 =?utf-8?B?YzFGTllnWWFaYmtyRFI1MUJwWGVIb2d2Ty9KeTRtWlVtOTBSYTFQem5Ga2Y1?=
 =?utf-8?B?K292MDZrYU5RQ0svUzlxWE93cThpcE8rdU1NNXJnbDYvKzJPL1gyV0xnbmtE?=
 =?utf-8?B?TG1WUTdYU0o5SExHSEt6QVlMK2FvbEl1OFAzdDRBSTdmdzlMVGRUdmJjQnlm?=
 =?utf-8?B?VEhEb1V6WmlsTnJpdndjNmU0UW5oK1M4QWRVS0VrSkZCKzlRT1I4eWNvbFNL?=
 =?utf-8?B?NjBFd2xMR2ROTnkzRVpyRFFZS2VEMXhEcGJvU243QUsvSTAxY0JUc2FmZTd2?=
 =?utf-8?B?K0RLRFZvRUxRbkh2eGZaSTJVMWdBVDZVc0JlZGNGR3hjYllFRzA0RGdTOFlw?=
 =?utf-8?B?bXB0UnNkSlV0a2poMzlWd3JvaWZDQkFEUXNCeGFudUJUQ1U4R3gyMkJpUkxC?=
 =?utf-8?B?aXlHWmxscUl3T3NsMjRSZytIR2Npa1VWWS94QXdOYWl0TWVHQVlFYjNMWjEr?=
 =?utf-8?B?V3UwMFArZzFaMW4rN0lrWDg0NHphbWVKQlkwTUtPQVZaVjFJNWt2VWJTdHZP?=
 =?utf-8?B?OWNFZlMwbHRwVFZ0NHMxZkFsazV3TmpTY0NYbytmV0V2elJGUjUyOVJ5QkJI?=
 =?utf-8?B?cis2dXFOSHJHTHl2Q0tRMytJSDEzUWhlZDdEVTBkaCs5bncwdDVTZVdiUm9q?=
 =?utf-8?B?ZHVGbERnTXZMMWdDQk91V1JkS3VmeVREZkx4UE85dlJxcUZhNHdBL2N0empj?=
 =?utf-8?B?MGE2QXhibHVXUlo0elI4cTFwMTA5RjlLaEMzVWhMNU03bGRRbENycjIyNkEr?=
 =?utf-8?B?Zk1xNjhXdWIxalRDY0N2Sko4RU9NSlFzSy9zNW9VTTlVdkNWcGVTMEt1bEZh?=
 =?utf-8?B?SWFrN1lvRURQRmRsTmdnQkx6d1RXM2kyMVZUSy9ENFg4dVliMWowYS9kcko0?=
 =?utf-8?B?WmIzTk95UWF0ZmRQTTI2TVJOZUNNRTRWK2VjY0MraXhrdE1wSHQrWGZiSHhC?=
 =?utf-8?Q?PVrbKD6sJWLEVNUGsn1+FkbBefDl2pxT3Go3eAG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5273.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 030193ce-0821-4836-ce79-08d9766c2a38
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2021 04:08:38.5511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I2rMxdt9h4ITg1UlFCmWi4OdXbHk36FcRW2SfnkUBrZ1dN4Qu3V4byTsuTkHkQoUP2HSAPkgDHf+VC4w4iB59A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5193
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Pj4gQWRkIHN1cHBvcnQgZm9yIE52aWRhIFRlZ3JhIGdlbmVyYWwgcHVycG9zZSBETUEgZHJpdmVy
IGZvcg0KPj4gVGVncmExODYgYW5kIFRlZ3JhMTk0IHBsYXRmb3JtLg0KPj4gDQo+PiBDaGFuZ2Vz
IGluIHBhdGNoIHY0Og0KPj4gCUFkZHJlc3NlZCByZXZpZXcgY29tbWVudHMgaW4gcGF0Y2ggdjMN
Cj4NCj4gV291bGQgYmUgZ29vZCB0byBiZSBzcGVjaWZpYywgYmVjYXVzZSBub3QgYWxsIHRoZSBj
b21tZW50cyBmcm9tIFYzIGhhdmUgYmVlbiBhZGRyZXNzZWQgOi0pDQo+DQo+IEpvbg0KDQpIaSBK
b24sDQpJIGFtIHNvcnJ5IHRoYXQgSSB0b3RhbGx5IG1pc3NlZCB0aGUgY29tbWVudHMgZnJvbSBQ
QVRDSCB2MyA0LzQgYW5kIHRob3VnaHQgSSBhZGRyZXNzZWQgYWxsIHRoZSBjb21tZW50cy4gV291
bGQgY29ycmVjdCB0aG9zZSBhcyB3ZWxsIGFuZCBzZW5kIG91dCBhIG5ldyB2ZXJzaW9uLg0KDQpU
aGFua3MsDQpBa2hpbA0KLS0NCm52cHVibGljDQo=
