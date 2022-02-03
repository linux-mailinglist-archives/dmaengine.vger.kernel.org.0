Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA9E4A7E6F
	for <lists+dmaengine@lfdr.de>; Thu,  3 Feb 2022 04:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344928AbiBCDo3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 2 Feb 2022 22:44:29 -0500
Received: from mail-dm6nam12on2074.outbound.protection.outlook.com ([40.107.243.74]:63324
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233713AbiBCDo1 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 2 Feb 2022 22:44:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c9dTcK9cppU3+NMQyPSGc+Vf/83XQUzO6F/9JEP7luTLcE4soFaO50PXbpmAGFRd4+fsED1lkoi/67nDhBZuT3l9Lkttq7HLKNKA8bDuTM7D5ueaJLjQ9YnC7lXQ+i+0LED4EUHksVnJjer05YFKkJCQoSZX989UTueC0lyrRzz0v5NsBv/kYQqGaOt3dXBjJckak6iaJRreyZicouLw4dXMahfznfbyJnnlHyKBzsMFBRmb6/f2mmMbe/uUrbxt8wbHUXi19U7EnwMMrK4xYMT0M5aP1J4mHE/xg35I0VCYBa7rypgmK12N7hXQ01sgY4npItuoJXgq47QA8uSk3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0W2d6DPKkifUHnDedhSqZ6ZA78uP47x1Ljx+xgBlvEM=;
 b=Q+sOfUrkT3xBICuIOkF5aNI4KghU5pP+YbREATcfv7UxFASCVbG95OfXs8OW6QOCPTgp1htRXN8rz6ixfj1fkXHgNibq2uiSG4hb0UXuFwEvx8oK+x0SiClb8Mmq4yFGNq/crZVKc2pDVjIHbH3xZQ5B3zCgT0FpWmSr9FZF+Cun6/qyzNyLtwOq1IovuvYq7LS8ZDDQtjNn5yNGhM3ibqV7kYKL+1xJypvwXAvOrWkHf1H6V2+ADXyaDS4adWw/Am58Ap9LnRS2vpJ6B+4hKNlugVXnMw2o83iE1DsuEGBeqz4T+Q/sPtceQWLHD9aHBkE0KEbiwusPPziQqCipcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0W2d6DPKkifUHnDedhSqZ6ZA78uP47x1Ljx+xgBlvEM=;
 b=CwLUJuSWWWF+i32MTGt6DGVzNVqMp9O/i00oU8vi7SXUOW5zHXqoNNgpCA+fWU84Due6wA9wK6VVeIaZ1WhvTr9745DLvZSHHSg3N5YTTWC3bBGz9LHAOql8UCC8jftf5pQqwUirWs+jLUwNWqNzyrMP4j2kkynUp5dfcwdfud086W8tSVa3GzU4q48KnCtT/Zw410td4f0pT7NCEChDEGXSfBfEE3NiucDOnQnViCCMZsOjm37WfGV5ExRFVsBoviT25qNyp9kd8gRnxdY9dNQO9lPrnUGoH/190hkTeFrYcBPygobVA+/mFIH7MrevMFV/PJ5kgAhg0TzH0S0LSw==
Received: from DM5PR12MB1850.namprd12.prod.outlook.com (2603:10b6:3:108::23)
 by BN7PR12MB2788.namprd12.prod.outlook.com (2603:10b6:408:30::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Thu, 3 Feb
 2022 03:44:25 +0000
Received: from DM5PR12MB1850.namprd12.prod.outlook.com
 ([fe80::94d8:5850:e33d:b133]) by DM5PR12MB1850.namprd12.prod.outlook.com
 ([fe80::94d8:5850:e33d:b133%4]) with mapi id 15.20.4930.022; Thu, 3 Feb 2022
 03:44:25 +0000
From:   Akhil R <akhilrajeev@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>,
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
Subject: RE: [PATCH v18 2/4] dmaengine: tegra: Add tegra gpcdma driver
Thread-Topic: [PATCH v18 2/4] dmaengine: tegra: Add tegra gpcdma driver
Thread-Index: AQHYF4A/XHCT9pN4OEO1Gc8heOMMp6yAaLaAgADG1FA=
Date:   Thu, 3 Feb 2022 03:44:25 +0000
Message-ID: <DM5PR12MB18509939C17ABEB5EEA825FFC0289@DM5PR12MB1850.namprd12.prod.outlook.com>
References: <1643729199-19161-1-git-send-email-akhilrajeev@nvidia.com>
 <1643729199-19161-3-git-send-email-akhilrajeev@nvidia.com>
 <3feaa359-31bb-bb07-75d7-2a39c837a7a2@gmail.com>
In-Reply-To: <3feaa359-31bb-bb07-75d7-2a39c837a7a2@gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db0389bf-7049-4646-ec81-08d9e6c77944
x-ms-traffictypediagnostic: BN7PR12MB2788:EE_
x-microsoft-antispam-prvs: <BN7PR12MB27889BC05F39230A00EC448AC0289@BN7PR12MB2788.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SSJBckyqEn3LumXrSilqfYzo2VkNaCWWnIKJD6FYrb3vtE4+fBN05h7uH+MwTAZVBrqQ6NpxgXV0PeSOU4OpaRTKEu7XSKSEzSi8bwRg2MhSgv5TmZQ0LK6/wSjpoUCqTuJnZI/U/rbr2FBAmSLXercexjxeYGEpoJqD619iYYq2963NN3l0mXKJSWHflgJxEYy6yb2+u0LxlG4ACh/ev6JIURk5URK5vawA59DNa5hpfqcsgv7+vLxP/0RBOiHda0fQau2MrkZkcK5oJ42H0SAo7ODeaWoAlfve3ogVEDxa8Aa1w2Jxv7QWixvweBQ3gV018fYsnZNAnESqCJT8Hy2iYedL5R4Y253URzHcdOGmxNw7sWB6KyLdWtZIlpTVKsOXmoObC2yLSnad1P66o0kuRN11uwCjfilcVPkVg+AAdFi3UXTJtXPn+Fw19BDTn756jNznXqJ/b81lo5E/0FnYC2ybLO3nk7wI9dqUP9Ullzqo3L0RFFXibQ3rA6v0Pm0Xyvu5S+vQ23BTJSiM9iOIWcze2DMmj7ekKeqJm9qzuLX8NESUFR1bnAlnSzWhIqEwWVbNfs/+HwmsuzBoxfoXrrfSaK9iZMiuefAL0xRACBJzliGyqfpD7uxCx2s/WrLwPYYnv9mgW1dnLhVBV2ADSAzTVcSYQtEe2wJ6UquC08ff5dx+gFhAE72PXknDjRLUHcY8HQc3uuEWh5FbzUsL07/jVIeOgUZX+iinw+w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1850.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(66946007)(6506007)(64756008)(9686003)(66476007)(8676002)(76116006)(66446008)(8936002)(186003)(66556008)(4326008)(921005)(7696005)(38100700002)(316002)(107886003)(38070700005)(71200400001)(122000001)(508600001)(86362001)(110136005)(55016003)(5660300002)(33656002)(2906002)(52536014)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RTg5dlRqTWV3b0kwM0x5dXY4dEpZM3h0bVpDSTBRUmhRSkU5N2twUVZzdmRL?=
 =?utf-8?B?c2tETmNpWUQvOEFiN3phNWk5Y0hLRFc0eGxWUExFeFhVY1dhSHo1YjlMWXQ2?=
 =?utf-8?B?NVJoMlM1YzRHYkVpNytub2I3UGpwNGtiM20yUlV3Y2pNT2JVL2ZLT2NhcUwy?=
 =?utf-8?B?SmRZQ2x1dklTSFlNMzI2Qjd1STNhNnJsYitZU0RxN21LaHpUckdtcm1Td2U1?=
 =?utf-8?B?Q2R3VEJ6V1VoSGdibjFHcXl5NWhFUXFyaXgwekdXODU5WTN2dDl2ZDZDaWtG?=
 =?utf-8?B?NEpOTFJCaWVHc3dYTEM0dDl2WHVkMUpqbStVbW1hVFNRSkp2WTR3K2Y0UVhl?=
 =?utf-8?B?RVVXc3Jwa2FqeHc5a2NXd3Rhc1lsWFBQN2pSVURBcndsUTdmc0E5RkV6VUw5?=
 =?utf-8?B?RTloYnByU3o5WmRHN2FDejNkbG5FSWlsQ2d5UG9nMk84eUd3cVVISmhpbjZs?=
 =?utf-8?B?TEtDTitqdFhrb3JYNmltUFoxTlM3eGZCTWhKUU5saFFBVVFLeUpDZXYwdG0z?=
 =?utf-8?B?UC9qc0swT2RiaUdab2s1UVFyVlc0aklrSURPS0JsVkVDcEtsQmdtQno2MUw4?=
 =?utf-8?B?SUV1MmlaSlRYWVVmQUFLQmxqakl6QkZzV2h0U1lxUTdGODZtNDlFQnlzcDRK?=
 =?utf-8?B?My81eDVOM3dtdjBQQmhRYzNycXNoVW1CeVJjUUxReWVSNlVDa0VnZ1JmTkYv?=
 =?utf-8?B?RXRFSG94MjRNcjFub2tMWjFhejlnYjhzMnZMUnJRcXZ4MDFvYmJ6VjR0aUpw?=
 =?utf-8?B?VUdHZEZUMzJCdlhDc3RQZ0RGSVJtQ0pMUWwxbjd2a002cHV5WGkzcVQ5M2JB?=
 =?utf-8?B?cWxYR0hZM3VtK3hobXo2aU8ybmtvRG9YMmtROWN4TVB5V05FWlVWeE1wK0Ra?=
 =?utf-8?B?U1BpUGp3MW0yWGJ6a24xVTRZcktsdk9mVXE3TUNxWjl0d0h0NTRvVEIvaHU2?=
 =?utf-8?B?TXhiM01wcEpCeXU4TW1RY1l1N3Z3cDZoSFZkL0VwQ2g4U00rUUMrTS9YUnF6?=
 =?utf-8?B?ajY5UGp2cWw3M1lqS2lHQU9qeFFLb3FnT1UxNHZnSkdHQ1NPd2c2TUZVWXl6?=
 =?utf-8?B?SW12TDY5VEhSVjMwV0RWZkZOWnUrRW5kdEgzVlNPMWRJUVVwL3JTNGY4NFZW?=
 =?utf-8?B?QWU4c3V2SStjS0NXaitvU1VvcnBSaXRUMFh0T1VVeE9OdUNacmpOOHlpbytz?=
 =?utf-8?B?UmRQNjU2TDZzMXN6OVNINWtIdHhUSlVObDRHWWhjQU5ld3M3Z2g4SXh0R1NX?=
 =?utf-8?B?dExsbm02Q3k3UEpxRHNVaTZ2RTRpa3Y4VGdKejh2YUdhSk9nRUIwRllKMnB1?=
 =?utf-8?B?MG56ODF2L2llNmQ4UnNxZVYzVXN5ZXBLRFNaMThLOFdKMWFsQkF4dzFnZ3JN?=
 =?utf-8?B?MWcwMlEyRkVqS2ROWnA0ZnNDclNpSEl3UFdoei9EaFpVNzQrY1FSVVM2c3h3?=
 =?utf-8?B?M3lwV1R0YkdBUTdydDd3bGhXWlNRckhUL2FoQVVPSFlmd0h6d1hUbmg0NEh0?=
 =?utf-8?B?bWpVa2ZPTHg4ZlJsa0VBT2dOSzdNRHNNbU9sdTZLeE41d2tXWnRQWUIzZFF1?=
 =?utf-8?B?MEpSNXczUkMxeTJoM0xuU1MrejdmQ0ljUjF6MDcvS2Q1dGQ2NjUyUWlQWXpj?=
 =?utf-8?B?OUtibFBLUTVMMUVYcVk0Q3RYVXBQUC84dytTR1Y4VkNyaW02ZGMzTStwWk5O?=
 =?utf-8?B?VFVtWm1Ddy94Y3ZJcGhCMlg5eUJZS0poL1hhWjh2cWhMT0dRYjlhNEdNZjJQ?=
 =?utf-8?B?a3hKZ1dkWVNTQWgrTU9LQzJ1MTRNM0ZHaS9scllhci9pbU1rZEt6SGdEcXpp?=
 =?utf-8?B?M0VTWmNqS1lDbldQTVVlN0paeTFySGhWWitxZGJDSUxJM1IrMGM5cjZ3K2t4?=
 =?utf-8?B?U0ZvOFNJek9hbnBWRFJBWTZURU5VODlmSFNkM0JUeVh2SUI0L25wc3NiKzQ4?=
 =?utf-8?B?ZXNQMTZpSGFCRldqMjlNVUxYRUdSNjVudGFBaE1LU3RGUEFEeGdFUzVtczBF?=
 =?utf-8?B?SWRlWXAzSWhVYjVaakFoS3pNcUYvRWxkaURiMHU5K1U4cWNoeW1rd1U0WUdx?=
 =?utf-8?B?a1NqYnNmVkxrbDJUQ0hpMGN2RE8vNmptU3dFVlZmVndQNFlFUDZHYk1PdFk1?=
 =?utf-8?B?L1VLWHpJWnUrL3NUNnl5QkpGUi9QbFh5M0hucmlvbGpVcGI4citOOFFoNHR4?=
 =?utf-8?B?Z1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1850.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db0389bf-7049-4646-ec81-08d9e6c77944
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2022 03:44:25.5982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gcJQ1oF3MXyZ498uzgvLAiaFJWbIC8U+SoTUniiTLsgB3U4E1oCTmdxsFRm2Zy5mUD6cMXoIZsKVncpWQpCbsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2788
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

PiAuLi4uDQo+ID4gK3N0YXRpYyBpbnQgdGVncmFfZG1hX3BhdXNlKHN0cnVjdCB0ZWdyYV9kbWFf
Y2hhbm5lbCAqdGRjKQ0KPiA+ICt7DQo+ID4gKyAgICAgaW50IHJldDsNCj4gPiArICAgICB1MzIg
dmFsOw0KPiA+ICsNCj4gPiArICAgICB2YWwgPSB0ZGNfcmVhZCh0ZGMsIFRFR1JBX0dQQ0RNQV9D
SEFOX0NTUkUpOw0KPiA+ICsgICAgIHZhbCB8PSBURUdSQV9HUENETUFfQ0hBTl9DU1JFX1BBVVNF
Ow0KPiA+ICsgICAgIHRkY193cml0ZSh0ZGMsIFRFR1JBX0dQQ0RNQV9DSEFOX0NTUkUsIHZhbCk7
DQo+ID4gKw0KPiA+ICsgICAgIC8qIFdhaXQgdW50aWwgYnVzeSBiaXQgaXMgZGUtYXNzZXJ0ZWQg
Ki8NCj4gPiArICAgICByZXQgPSByZWFkbF9yZWxheGVkX3BvbGxfdGltZW91dF9hdG9taWModGRj
LT50ZG1hLT5iYXNlX2FkZHIgKw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICB0ZGMtPmNoYW5f
YmFzZV9vZmZzZXQgKyBURUdSQV9HUENETUFfQ0hBTl9TVEFUVVMsDQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgIHZhbCwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgISh2YWwgJiBURUdSQV9H
UENETUFfU1RBVFVTX0JVU1kpLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICBURUdSQV9HUENE
TUFfQlVSU1RfQ09NUExFVEVfVElNRSwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgVEVHUkFf
R1BDRE1BX0JVUlNUX0NPTVBMRVRJT05fVElNRU9VVCk7DQo+ID4gKw0KPiA+ICsgICAgIHJldHVy
biByZXQ7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgdGVncmFfZG1hX2RldmljZV9w
YXVzZShzdHJ1Y3QgZG1hX2NoYW4gKmRjKQ0KPiA+ICt7DQo+ID4gKyAgICAgc3RydWN0IHRlZ3Jh
X2RtYV9jaGFubmVsICp0ZGMgPSB0b190ZWdyYV9kbWFfY2hhbihkYyk7DQo+ID4gKyAgICAgdW5z
aWduZWQgbG9uZyBmbGFnczsNCj4gPiArICAgICBpbnQgcmV0ID0gMDsNCj4gPiArDQo+ID4gKyAg
ICAgaWYgKCF0ZGMtPnRkbWEtPmNoaXBfZGF0YS0+aHdfc3VwcG9ydF9wYXVzZSkNCj4gPiArICAg
ICAgICAgICAgIHJldHVybiAtRU5PU1lTOw0KPiA+ICsNCj4gPiArICAgICBzcGluX2xvY2tfaXJx
c2F2ZSgmdGRjLT52Yy5sb2NrLCBmbGFncyk7DQo+ID4gKyAgICAgcmV0ID0gdGVncmFfZG1hX3Bh
dXNlKHRkYyk7DQo+ID4gKyAgICAgaWYgKHJldCkNCj4gPiArICAgICAgICAgICAgIGRldl9lcnIo
dGRjMmRldih0ZGMpLCAiRE1BIHBhdXNlIHRpbWVkIG91dFxuIik7DQo+IA0KPiBXaHkgZXJyb3Ig
bWVzc2FnZSBzaG91bGRuJ3QgYmUgcHJpbnRlZCBieSB0ZWdyYV9kbWFfdGVybWluYXRlX2FsbCgp
Pw0KPiANCj4gVGhlIGVycm9yIG1lc3NhZ2Ugc2hvdWxkIGJlIHBsYWNlZCBpbnNpZGUgb2YgdGVn
cmFfZG1hX3BhdXNlKCkuDQpPa2F5LiBBZ3JlZWQuDQo+IA0KPiAuLi4NCj4gPiArc3RhdGljIGlu
dCB0ZWdyYV9kbWFfc3RvcF9jbGllbnQoc3RydWN0IHRlZ3JhX2RtYV9jaGFubmVsICp0ZGMpDQo+
ID4gK3sNCj4gPiArICAgICBpbnQgcmV0Ow0KPiA+ICsgICAgIHVuc2lnbmVkIGxvbmcgc3RhdHVz
Ow0KPiA+ICsgICAgIHUzMiBjc3IgPSB0ZGNfcmVhZCh0ZGMsIFRFR1JBX0dQQ0RNQV9DSEFOX0NT
Uik7DQo+ID4gKw0KPiA+ICsgICAgIC8qDQo+ID4gKyAgICAgICogQ2hhbmdlIHRoZSBjbGllbnQg
YXNzb2NpYXRlZCB3aXRoIHRoZSBETUEgY2hhbm5lbA0KPiA+ICsgICAgICAqIHRvIHN0b3AgRE1B
IGVuZ2luZSBmcm9tIHN0YXJ0aW5nIGFueSBtb3JlIGJ1cnN0cyBmb3INCj4gPiArICAgICAgKiB0
aGUgZ2l2ZW4gY2xpZW50IGFuZCB3YWl0IGZvciBpbiBmbGlnaHQgYnVyc3RzIHRvIGNvbXBsZXRl
DQo+ID4gKyAgICAgICovDQo+ID4gKyAgICAgY3NyICY9IH4oVEVHUkFfR1BDRE1BX0NTUl9SRVFf
U0VMX01BU0spOw0KPiA+ICsgICAgIGNzciB8PSBURUdSQV9HUENETUFfQ1NSX1JFUV9TRUxfVU5V
U0VEOw0KPiA+ICsgICAgIHRkY193cml0ZSh0ZGMsIFRFR1JBX0dQQ0RNQV9DSEFOX0NTUiwgY3Ny
KTsNCj4gPiArDQo+ID4gKyAgICAgLyogV2FpdCBmb3IgaW4gZmxpZ2h0IGRhdGEgdHJhbnNmZXIg
dG8gZmluaXNoICovDQo+ID4gKyAgICAgdWRlbGF5KFRFR1JBX0dQQ0RNQV9CVVJTVF9DT01QTEVU
RV9USU1FKTsNCj4gPiArDQo+ID4gKyAgICAgLyogSWYgVFgvUlggcGF0aCBpcyBzdGlsbCBhY3Rp
dmUgd2FpdCB0aWxsIGl0IGJlY29tZXMNCj4gPiArICAgICAgKiBpbmFjdGl2ZQ0KPiA+ICsgICAg
ICAqLw0KPiA+ICsNCj4gPiArICAgICByZXQgPSByZWFkbF9yZWxheGVkX3BvbGxfdGltZW91dF9h
dG9taWModGRjLT50ZG1hLT5iYXNlX2FkZHIgKw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHRkYy0+Y2hhbl9iYXNlX29mZnNldCArDQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgVEVHUkFfR1BDRE1BX0NIQU5fU1RBVFVTLA0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHN0YXR1cywNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAh
KHN0YXR1cyAmIChURUdSQV9HUENETUFfU1RBVFVTX0NIQU5ORUxfVFggfA0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIFRFR1JBX0dQQ0RNQV9TVEFUVVNfQ0hBTk5FTF9SWCkpLA0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDUsDQo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgVEVHUkFfR1BDRE1BX0JVUlNUX0NPTVBMRVRJT05fVElNRU9VVCk7DQo+
ID4gKyAgICAgaWYgKHJldCkgew0KPiA+ICsgICAgICAgICAgICAgZGV2X2Vycih0ZGMyZGV2KHRk
YyksICJUaW1lb3V0IHdhaXRpbmcgZm9yIERNQSBidXJzdA0KPiBjb21wbGV0aW9uIVxuIik7DQo+
ID4gKyAgICAgICAgICAgICB0ZWdyYV9kbWFfZHVtcF9jaGFuX3JlZ3ModGRjKTsNCj4gPiArICAg
ICB9DQo+ID4gKw0KPiA+ICsgICAgIHJldHVybiByZXQ7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0
YXRpYyBpbnQgdGVncmFfZG1hX3Rlcm1pbmF0ZV9hbGwoc3RydWN0IGRtYV9jaGFuICpkYykNCj4g
PiArew0KPiA+ICsgICAgIHN0cnVjdCB0ZWdyYV9kbWFfY2hhbm5lbCAqdGRjID0gdG9fdGVncmFf
ZG1hX2NoYW4oZGMpOw0KPiA+ICsgICAgIHVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+ID4gKyAgICAg
TElTVF9IRUFEKGhlYWQpOw0KPiA+ICsgICAgIGludCBlcnI7DQo+ID4gKw0KPiA+ICsgICAgIHNw
aW5fbG9ja19pcnFzYXZlKCZ0ZGMtPnZjLmxvY2ssIGZsYWdzKTsNCj4gPiArDQo+ID4gKyAgICAg
aWYgKHRkYy0+ZG1hX2Rlc2MpIHsNCj4gPiArICAgICAgICAgICAgIGVyciA9IHRkYy0+dGRtYS0+
Y2hpcF9kYXRhLT5od19zdXBwb3J0X3BhdXNlID8NCj4gPiArICAgICAgICAgICAgICAgICAgIHRl
Z3JhX2RtYV9wYXVzZSh0ZGMpIDoNCj4gPiArICAgICAgICAgICAgICAgICAgIHRlZ3JhX2RtYV9z
dG9wX2NsaWVudCh0ZGMpOw0KPiANCj4gVGhlIGNhbm9uaWNhbCBjb2Rpbmcgc3R5bGUgaXM6DQo+
IA0KPiBpZiAodGRjLT50ZG1hLT5jaGlwX2RhdGEtPmh3X3N1cHBvcnRfcGF1c2UpDQo+ICAgICAg
ICAgZXJyID0gdGVncmFfZG1hX3BhdXNlKHRkYyk7DQo+IGVsc2UNCj4gICAgICAgICBlcnIgPSB0
ZWdyYV9kbWFfc3RvcF9jbGllbnQodGRjKTsNCj4gDQpPa2F5Lg0KPiANCj4gQnV0IHdoeSBkbyB5
b3UgbmVlZCB0byBwYXVzZSBhdCBhbGwgaGVyZSBhbmQgY2FuJ3QgdXNlDQo+IHRlZ3JhX2RtYV9z
dG9wX2NsaWVudCgpIGV2ZW4gaWYgcGF1c2UgaXMgc3VwcG9ydGVkPw0KDQpUaGUgcmVjb21tZW5k
ZWQgbWV0aG9kIHRvIHRlcm1pbmF0ZSBhIHRyYW5zZmVyIGluDQpiZXR3ZWVuIGlzIHRvIHBhdXNl
IHRoZSBjaGFubmVsIGZpcnN0IGFuZCB0aGVuIGRpc2FibGUgaXQuDQpUaGlzIGlzIG1vcmUgZ3Jh
Y2VmdWwgYW5kIHN0YWJsZSBmb3IgdGhlIGhhcmR3YXJlLg0Kc3RvcF9jbGllbnQoKSBpcyBtb3Jl
IGFicnVwdCwgdGhvdWdoIGl0IGRvZXMgdGhlIGpvYi4NCg0KVGhhbmtzLA0KQWtoaWwNCg==
