Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0060257CDCE
	for <lists+dmaengine@lfdr.de>; Thu, 21 Jul 2022 16:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiGUOhN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Jul 2022 10:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbiGUOhM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 Jul 2022 10:37:12 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2139.outbound.protection.outlook.com [40.107.113.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5352A8320B;
        Thu, 21 Jul 2022 07:37:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GCbAh590aGGINwLkrQAnXmjWCOkxe3SIEWUudXmcQEjfR6T5PchhAnzmPrtipGIh47I5PB7nOeA5ZCD40wp+WxdHw+ym1EoQEJ+i2ec+VQMX4EAxkXG9mpv/QRkFQ7m1zBcN58nuD1Kx/E4oC3miCrFciQclVNH7jkEQo41TkVuKbvOpxk45ZuVpVDZST2GasqBpsfAfFekoJaKNQ6HJX8XH8RFCIXuhPnPL5/+B+W7Pz0iadrljEoDPL22PZlJPdr4KzivZpV3cmo8mq2DQL4NrVPVfzbl6ZXTPp5QROWJk3OsZwqZhdZg0rJHhlq+feIUYnqQk/xBxwUBa3V1Efg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AIW+ya69q+xvVQBBBYDwhHG8dGdL0Xv8sA09MdNJXA0=;
 b=Tbh86zPs6AsruEgZ6uSKaBhstSSemUBrFvmPB0sHqqxMpKKjkj/zW04njRMgtM4p110vXKPZ9GAMLidcRzICGFE5WlJxdGJRSD7iFup2kBgreK1UzlNgSJ+lI+4B5J8W7UFAsA254rnaaE3Lqc+HDya++8AKn8W02ZW45bvF0cGlNdlkWNRPfFEdSFd1zbwDF5zfDh8eFbNK36UsxtaAYFviEhldqcxA9Lt4mSLn532S2S0FzL56JiN3cOanRLhOU2bvoyEviqUIstg9Sjn2jjjnx8HXsZzKI2OBRn5TAkAha20juz18yXAQeTSh+YnjEnQh0RdbriUTzl/jInWdMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AIW+ya69q+xvVQBBBYDwhHG8dGdL0Xv8sA09MdNJXA0=;
 b=enNbaG3kEzyARU9zLwUj6fOACvgr4qqO8M4O0VXLmzjZKrnf3OKUPED6POJ7fsuOccuLkJe3QtimP+j3BWWYyNgP9LVEweVONyFFSx5LzI2NHhUisYjd1KIpo0VWDcm6mkgty7koeE6HuhCqLGUnUJf0OPjqiIUxJgJQbHTrPDE=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSAPR01MB4835.jpnprd01.prod.outlook.com (2603:1096:604:68::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Thu, 21 Jul
 2022 14:37:07 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b046:d8a3:ac9c:75b5]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b046:d8a3:ac9c:75b5%6]) with mapi id 15.20.5458.019; Thu, 21 Jul 2022
 14:37:06 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Vinod Koul <vkoul@kernel.org>,
        Colin Ian King <colin.king@intel.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        dmaengine <dmaengine@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] dmaengine: sh: rz-dmac: Add device_synchronize
 callback
Thread-Topic: [PATCH v2 1/2] dmaengine: sh: rz-dmac: Add device_synchronize
 callback
Thread-Index: AQHYm4A9SxOtiLZTzkSonUjFKh7hMK2IlrAAgAACLACAAE6M0A==
Date:   Thu, 21 Jul 2022 14:37:06 +0000
Message-ID: <OS0PR01MB59222F083AA489C87D02024F86919@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220719150000.383722-1-biju.das.jz@bp.renesas.com>
 <CAMuHMdVoU4LHiZmxM_DsGz5kMFAbRzvwJwtkcgCKp3SBtYW6ww@mail.gmail.com>
 <CAMuHMdXE36V9dB9C4UmoYnfiYLp-u2XM0fdSwmQpB1DgGoBthA@mail.gmail.com>
In-Reply-To: <CAMuHMdXE36V9dB9C4UmoYnfiYLp-u2XM0fdSwmQpB1DgGoBthA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aaf1e783-8f05-4c6d-8d9c-08da6b267c77
x-ms-traffictypediagnostic: OSAPR01MB4835:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dVirMVUcHZgmns+rWue0P4XvsN1LDdj9dsvlfMAvl/WXbYLERjjz2KNzfr720ToET39Jy9j+fXS0M+gtXFCPNciqjxXNCUYQtD4q+ZXCJQtSA1SKQHV0GUZFF5gyg1/07R5YDmRRTDNWPgejI5JAGm9LYXx8XK7nK8HHW29wnM0SqFbeOWr73VlqtP4Rieg3o0WSy5gMbhB5kpbSvxhUyGBoBWfMrGNR6A3EEd9zX+jpK9SRKtu8U98Q/VQfKOOMU0fHz3/LJeogCLIgx1zF/5QM6/w4nOOxqaExZj28qkRMipRm6mts/ttdS3BtgDis23+eLYXv9a41ZOj31a6LSFz/XAev5p8nnn/w8x6oTZa/f85NG4dwQPypEeTOeSU+nlHjx0xHiA3alt+BcuwvXBBMmEm683RVunL10pxB5VL1ax7dOurpG7YBosexa4ypnuyNrZXVVQlCkDKlxS8pZasZIPjecuhOYMhVFdqLqh3d7RI9mFoxfHknK9GfHXjudOnaSKqu2LVO6hjFyIRBYS0Dx+KFgVpPg6/I02tPlh5r43mQmxGcafBgUr0EzHlQ0TRdoLCZRcBbKwGnTPkV01g4r0KcFqqNJx7Q98iROOpJZmWubGY/Qv2H6y0x//T0mhfRTaaYQeJ0VLoup3BCt2SHlYIpA5Ta4xKV1nFB0rgokge7jF4xmR/CxTIejLeQPbKs7vzWdar1imziK1RYk2YR4DMmhNeh5DSTr+oEJ56WzDzN7H+5ckpwJs5rBTRY0Qe1TYjio7zR+buTdQye7P6lQkEpWGudr8+8uiAWCuHw9EVmjRhTA1BS5F17luZw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(396003)(346002)(136003)(366004)(6916009)(76116006)(71200400001)(66476007)(186003)(64756008)(316002)(55016003)(66946007)(83380400001)(66446008)(4326008)(9686003)(53546011)(2906002)(26005)(8676002)(41300700001)(6506007)(66556008)(7696005)(54906003)(38070700005)(33656002)(86362001)(8936002)(5660300002)(478600001)(38100700002)(122000001)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VWRrYWpUNHU1SVFVZENMSXd0Vnc0M0QvcXBzUzhienZXT1lBcVZvS1pldkdl?=
 =?utf-8?B?aTdWaWhMbDJCK1ExMzh4NEdkL1hLbjRyTEtBQVFKaGVPS3lLcTNSa1pZL2s3?=
 =?utf-8?B?R21aNkVmSVZJb0FDblIycW13UzVpM0YwNkRya1FsbGlvMUt2T1hNZ3huREp3?=
 =?utf-8?B?eDdJOFBjcy80UUFuRFM4RGVKQ1FIQlUxUzFOUC9nMVdkRGZaVzNtWWR2QUE3?=
 =?utf-8?B?dmRGUGFCNTJjbEtGclBYaUxpVng4dCszYmRiVTdCTWgzMkZBbDRHbG5EaSs1?=
 =?utf-8?B?WjNKZEV4a1NGbkVKZlFubjI0VmhWNDJtT3BUc2dIRHF4VjlsUnpwNmxaYTJS?=
 =?utf-8?B?Vm9LWGdiWEFLQSt6U2dZRGJEaWZRZm1ISFlaOTBDOHVZZWR3Ni9YSmtkTlRB?=
 =?utf-8?B?aVVacW5TMGJJNTArK1dkampxZnlQYmQwMXVXV1J2S0pCMHNTZ3FtaTM2Tm44?=
 =?utf-8?B?VUI2bU1wZ3UvaHVWdGo5MGRxRUJndll1UTVoc3JWa241Z2FWVFZNTExWYjZh?=
 =?utf-8?B?TVpKSzJZay8xVTBUYmlheGVhV3hHeERlMHliSzFZQ2JsN0VOU3ZiWEMyNnpo?=
 =?utf-8?B?NEJGMnE2Mk9IUDE3UWx6NklUMEhTK1lwdWloc0cwZVBzN2pvTGdDbm5Pc0lw?=
 =?utf-8?B?S2hXY2xPRkhOTEVlVEdSQXJIMzJDcHhDVzVVdTNwdkpQTmJTV2VRZVgyVDZ2?=
 =?utf-8?B?RjlYc25Rd3RJY2tnY0V3Y1BYM3FUeEVlM3ZabldKVWdURVYrV0IwdUxwVjhr?=
 =?utf-8?B?Ny9IZ1JUcCtzTUZjZlNVZGV6TkMrWXg3UXV1TWU5RVdLREtxcjN5b3J1a3Rr?=
 =?utf-8?B?RWZTd2pzREMxalBmNEV3a2d4VzY3RDhBYnRCbWdidjdlMytHQVNqcDhDTEVj?=
 =?utf-8?B?VGR4bG52M0tKL3JPaUczRDhLVDExNWp4SmJpbFdkalhoNlc2QjVYVjV2L2E3?=
 =?utf-8?B?M25SMzhKcWlPSUtKNDJYTUhrUjFRN3lyQXJBVHYyWjhDL3VLSnVnNGcyNFlx?=
 =?utf-8?B?TnhnaEt4VVYwZlpxR2tQeURlV1F0VVVpb2JXQTFpUWxlYUdydW1EODhYdnVo?=
 =?utf-8?B?SW9MUWs1dEpiMFQ0by84RlM5YW1WOWd0bXRjMmZPc3U3TXBUVWhnQlR5b2kx?=
 =?utf-8?B?QUs4U0Fqd2hoVDduclNnN0h3bXEvNEJZN2hpSW5oM0c5TzJEQ1M1TEpRZmxh?=
 =?utf-8?B?QmZ5UGd1Qk9QOEVRSkhPS0NMV2hmMWJEVzFGUlR3MVZwc29OM2R6SnVSNm0v?=
 =?utf-8?B?aUF6eCs3Ym04eFF6K3FrSjc5SzZPK0ZDeDNvOHIvZ25TRXhrUTg5NjB3bk1S?=
 =?utf-8?B?NzFnSzJBK0ZPUWNma3g3U0JJQlV1Q29PdGpNNFRjMTRBdlUwVDJ6S21sSWx5?=
 =?utf-8?B?OGZSWHZpYkxYVmd2dGt4NTl1NkNMUzR2M05NcEwyeENuNGZHQTJlcWpma0Z3?=
 =?utf-8?B?UkhUN1RMbm1zM0ZCU2dzUGhaelJFTksyS3k3UnpZaFBZSkdZSXBQUFFVdzBZ?=
 =?utf-8?B?azAyazRUYmpYTXFEaGZpQm5KKzlURHhiUldLSUpqdVZ2dEZ2UlpKZHFSQjg2?=
 =?utf-8?B?VUNlTlpXT2pkYVdlQWtLNVZqYWZLLzhvSm5sQ2VpYnNoYmxZOGpCNzRIQllR?=
 =?utf-8?B?QzEwREp5T0NUR3BuMXBOeFN3TXhGaDk1T0FBcE9WbVVBNkIwQlFuOXVlb2VF?=
 =?utf-8?B?VG9lUkduRkdUMlhsNDFsNExXbTFvSFZCMVgxV1QwZ2NWS1JZVWRkTGxxcmlz?=
 =?utf-8?B?aDV4dzE3cFJJMWxkZGt2ZmFMbCtNUXpGQ2lacDNUN0RIdmkzZzJPL2RrQ0RE?=
 =?utf-8?B?VzNXN2NXWVNVT1BSTWFsejcyc1gxdE9tWUJNMDI2aWZ0OU9PZTRFU3hpSXhE?=
 =?utf-8?B?Z2c1Z242YWJ3T3dKcE9tM3JuZmFReXVpa0U3STBFWXBnM25rUk5GODhyWkV5?=
 =?utf-8?B?SGpWRXd5aVdrRHJTcyt3QmpqY1A4MEEyamZGZ1VKcld6a0RPdmZDdmJ0dlVQ?=
 =?utf-8?B?TnZCSnFkRUVsRlpqSVFySEVnSjcrdC9rci93RytIMWFGWjZlL205WitSVW9t?=
 =?utf-8?B?WGFoMHdZS1g3UEtNZDlPTjRRMEhiRnZXakV4UjkwZ3ljOVZQL3kraEkzT0Vp?=
 =?utf-8?B?c043dVVRY3Z6dnBUN2RNaWhpUnZqUHFGOGlDZmx6cTd4Wk45ZEcvMVdpSjBY?=
 =?utf-8?B?Nmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaf1e783-8f05-4c6d-8d9c-08da6b267c77
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2022 14:37:06.7173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: guD+p4ZsL39CwLwvA7arHmPBh8bXa+RtBFm6daueYdb34beMzgtDNOogAE9EcF0Rpb8u5IOxO0ZrRnWkcZa1Srj5xutpUP9/MkmWIbXGS9k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4835
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjIgMS8yXSBkbWFlbmdpbmU6IHNoOiByei1kbWFjOiBBZGQNCj4gZGV2aWNlX3N5bmNo
cm9uaXplIGNhbGxiYWNrDQo+IA0KPiBIaSBCaWp1LA0KPiANCj4gT24gVGh1LCBKdWwgMjEsIDIw
MjIgYXQgMTE6NDcgQU0gR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC0NCj4gbTY4ay5v
cmc+IHdyb3RlOg0KPiA+IE9uIFR1ZSwgSnVsIDE5LCAyMDIyIGF0IDU6MDAgUE0gQmlqdSBEYXMg
PGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiB3cm90ZToNCj4gPiA+IFNvbWUgb24tY2hp
cCBwZXJpcGhlcmFsIG1vZHVsZXMoZm9yIGVnOi0gcnNwaSkgb24gUlovRzJMIFNvQyB1c2UgdGhl
DQo+ID4gPiBzYW1lIHNpZ25hbCBmb3IgYm90aCBpbnRlcnJ1cHQgYW5kIERNQSB0cmFuc2ZlciBy
ZXF1ZXN0cy4NCj4gPiA+IFRoZSBzaWduYWwgd29ya3MgYXMgYSBETUEgdHJhbnNmZXIgcmVxdWVz
dCBzaWduYWwgYnkgc2V0dGluZyBETUFSUywNCj4gPiA+IGFuZCBzdWJzZXF1ZW50IGludGVycnVw
dCByZXF1ZXN0cyB0byB0aGUgaW50ZXJydXB0IGNvbnRyb2xsZXIgYXJlDQo+ID4gPiBtYXNrZWQu
DQo+ID4gPg0KPiA+ID4gV2UgY2FuIGVuYWJsZSB0aGUgaW50ZXJydXB0IGJ5IGNsZWFyaW5nIHRo
ZSBETUFSUy4NCj4gPg0KPiA+IHJlLWVuYWJsZT8NCj4gPg0KPiA+ID4NCj4gPiA+IFRoaXMgcGF0
Y2ggYWRkcyBkZXZpY2Vfc3luY2hyb25pemUgY2FsbGJhY2sgZm9yIGNsZWFyaW5nIERNQVJTIGFu
ZA0KPiA+ID4gdGhlcmVieSBhbGxvd2luZyBETUEgY29uc3VtZXJzIHRvIHN3aXRjaCB0byBETUEg
bW9kZS4NCj4gPg0KPiA+IGludGVycnVwdCBtb2RlDQo+ID4NCj4gPiA+DQo+ID4gPiBTaWduZWQt
b2ZmLWJ5OiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+ID4gPiAtLS0N
Cj4gPiA+IHYxLT52MjoNCj4gPiA+ICAqIE5vIGNoYW5nZQ0KPiA+DQo+ID4gV2l0aCB0aGUgYWJv
dmUgZml4ZWQ6DQo+ID4gUmV2aWV3ZWQtYnk6IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnQrcmVu
ZXNhc0BnbGlkZXIuYmU+DQo+IA0KPiA+ID4gK3N0YXRpYyB2b2lkIHJ6X2RtYWNfZGV2aWNlX3N5
bmNocm9uaXplKHN0cnVjdCBkbWFfY2hhbiAqY2hhbikgew0KPiA+ID4gKyAgICAgICBzdHJ1Y3Qg
cnpfZG1hY19jaGFuICpjaGFubmVsID0gdG9fcnpfZG1hY19jaGFuKGNoYW4pOw0KPiA+ID4gKyAg
ICAgICBzdHJ1Y3QgcnpfZG1hYyAqZG1hYyA9IHRvX3J6X2RtYWMoY2hhbi0+ZGV2aWNlKTsNCj4g
PiA+ICsNCj4gDQo+IEFjdHVhbGx5IHRoaXMgc2hvdWxkIGNoZWNrIGlmIHRoZSBETUEgb3BlcmF0
aW9uIGhhcyBiZWVuIGNvbXBsZXRlZCBvcg0KPiB0ZXJtaW5hdGVkLCBhbmQgd2FpdCAoc2xlZXAp
IGlmIG5lZWRlZC4NCg0KT0sgd2lsbCBzZW5kIHYzIHdpdGggdGhlc2UgY2hhbmdlcy4NCg0KQ2hl
ZXJzLA0KQmlqdQ0KDQo=
