Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9895E60C698
	for <lists+dmaengine@lfdr.de>; Tue, 25 Oct 2022 10:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbiJYIhK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Oct 2022 04:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbiJYIhJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 25 Oct 2022 04:37:09 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150084.outbound.protection.outlook.com [40.107.15.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E5F77E89;
        Tue, 25 Oct 2022 01:37:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j9XKAlITlkMyc072UmylO1oOqQYtx6hd8ML2fU2JPEdid/VsJhMMyKR9aF4PvZF0bchPNCfEwQt2BPFJ96GEcZ63eTZA9L99SJwOy1eUzSkjQ/nIh28qFJmwcCTF9z65/jI7UNgl0lTIHog9xoZlIlWVCQwALM4n3zytp731DABjlljvRlc04JBmn7eShGuzudeq26S3+SbPj338G24XdxxwnQrUeRtYJWRPnSNO8snK5++qfOLTigmJ8MW2V/AxGB87ujEvfkNp199wpPPpj5jzDJJ/Ck3y+ul+8VkMYh69QZ+fby2M54XTjpeC18Om5X8L1dT0gJREDtAEOEFDJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0oRrC5HRsg/8A9KESDsi8i1+s9yB5GjnGhyDdno2h5o=;
 b=mNWXBZmdmz5vTvA2xwEzJfF12b60SEPEINfysZrNAtjQrXjEn8tbOpslVK5FKXo6srwMScxo4VG5yF8yHBskmLyguGgDBlk3+qcpGZuiVKw0M3UaO9pLPkCcu2K79E29ukW3j+QKPHBIuGsAc7clpN1Z3J5cXhd86VzumMA9I0f57doklTMZij+jdA64zkJNWfV35CbKZm3LM7qJMl1eDj+H0ypcvpuckdlddteVE8lgym9jzAjDCkYa4q2cdh9grxk1bhHYcKjcLlOOqw0ONXz/wp6Gx1W4+TYDEYJsEnfoerXWlKJSnjcsGl/awhV5RJs/fUJaYbWeFRRVtF1Qjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0oRrC5HRsg/8A9KESDsi8i1+s9yB5GjnGhyDdno2h5o=;
 b=Hj3D0NmIr7AWm1HuCJjq+fK+0tzI13E8haAH07cKdFmM0LYrlsRGbb4Q0Xm9rpXnCXZzbyLmciEf1sz48wfmFzO12vSYsfXcHoYaOtM/UyLa88Fc+KtucCdHRMcPYacb+w31HwCmI5p4R6zUYjm9U9cNOwpQT+XF5HI9iBpaVv0=
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com (2603:10a6:20b:ab::19)
 by VI1PR04MB6928.eurprd04.prod.outlook.com (2603:10a6:803:12e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Tue, 25 Oct
 2022 08:37:01 +0000
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::7a34:469:fd53:922c]) by AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::7a34:469:fd53:922c%7]) with mapi id 15.20.5746.021; Tue, 25 Oct 2022
 08:37:01 +0000
From:   Joy Zou <joy.zou@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>
CC:     "S.J. Wang" <shengjiu.wang@nxp.com>,
        "martink@posteo.de" <martink@posteo.de>,
        "dev@lynxeye.de" <dev@lynxeye.de>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        Peng Fan <peng.fan@nxp.com>, "david@ixit.cz" <david@ixit.cz>,
        "aford173@gmail.com" <aford173@gmail.com>,
        Hongxing Zhu <hongxing.zhu@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v7 1/2] dt-bindings: fsl-imx-sdma: Convert imx
 sdma to DT schema
Thread-Topic: [EXT] Re: [PATCH v7 1/2] dt-bindings: fsl-imx-sdma: Convert imx
 sdma to DT schema
Thread-Index: AQHY5GzccQmLkJcvCUiJFUjVMGEDSa4XegGAgAD4iUCAAF/EgIAF/mLA
Date:   Tue, 25 Oct 2022 08:37:01 +0000
Message-ID: <AM6PR04MB592555F3CB5EA0C6E518FE25E1319@AM6PR04MB5925.eurprd04.prod.outlook.com>
References: <20221020101402.1856818-1-joy.zou@nxp.com>
 <20221020101402.1856818-2-joy.zou@nxp.com>
 <caae2af7-96ea-195f-6f33-05d9e79fa518@linaro.org>
 <AM6PR04MB5925C0AC7A4066AF52E2004CE12D9@AM6PR04MB5925.eurprd04.prod.outlook.com>
 <ceb8eb7f-8e10-bfdf-bc22-1f9eddb2ea83@linaro.org>
In-Reply-To: <ceb8eb7f-8e10-bfdf-bc22-1f9eddb2ea83@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5925:EE_|VI1PR04MB6928:EE_
x-ms-office365-filtering-correlation-id: 67875162-af1d-4418-9b79-08dab664166e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KtXuU+a10fZPwGvk5A98OyafcRNDKJbde5ZiNkc6kAaeZF9sdPhnW28uh8YN56g/Ru9h3TO5T/hqrGTVBCz74gAxWy3LqS+ETTfZ9NURKsiqLkbIrngC1T/A1ulAIztPahRUXRVulg8CiWUCkP+Kr8RhIbu7DZhklAgvm9tc6HbxxMA57mQy94LBk5ikKRJG0sNdDv8kM+6rq3/DP3uWnWJ4TKDnQWY/uagV8whZ+K6EK78jnosDsFxizJwGGpr4DNgZpGRk2W9nq6D6icOzGRkeJZTgHdUuVXvLYYPBhSfBB3fIFo960jpdQ6skfrtzn2+zU2Y21AZ6LHYI0tqmbYw9YfFS8Q8lgpPAfvdq13o9nyXCYtGt+gDFGRtZbnTASle9pRcD++CMqe17N1/bUYIFhl+heXcOllDIUbSvWAgMyMB5WnfTE7Dfofu3RhmvPbYE8zVTmDDAFX07W9dFEqaVODLAmXyN81jB/YyLXveInyMJwngZUuq2zM3uPJnLou7KZQj5GaJxkJqt19P7ychIhjXKmBmL8xXtTtc8/BbmeFHjljTD9hmHt8gq4b49a2X45/ygJk5Mmwkm9HA7T1QL9ctLcBxkP+ie+uX7RXtkVpNWxS0jfpLBe06DDfDzHVGMF6aWMz/TF2TXm42fFjqp8rI5Y+3CWpWGRWUqXCbn03kDLgMn5I1UzN3VeV/Kab3mrKepyyrtp68V5GNUuRc1optrcI/cznYDs5vOtq2ZJb2ddocyntpw7l/AZdWSexXNF/RMwfoyyKmFhNntrw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5925.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(39860400002)(346002)(396003)(136003)(451199015)(9686003)(26005)(53546011)(478600001)(6506007)(7696005)(83380400001)(186003)(44832011)(2906002)(55016003)(54906003)(316002)(71200400001)(76116006)(52536014)(110136005)(8936002)(5660300002)(7416002)(4326008)(8676002)(64756008)(66446008)(66476007)(66556008)(66946007)(41300700001)(86362001)(33656002)(38100700002)(122000001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WmI1NGRVSUJpU0Z6SUpWOEhqTFhZRTRsSzBKR0lVdDkyUmNhL09tc0lZZlBz?=
 =?utf-8?B?Qm40aGNTYnBYODRwMkl4S1NsRnVYY0lwVnRpZ0NGaHRGMzUwaThVT3I0aUJn?=
 =?utf-8?B?c1dJUlZ2RFBsQlhpTWpqR0Z1NVhnZXZtQkEvRlE5eDMzZ1pFYW1kQUp1YU9t?=
 =?utf-8?B?SEtaU25QemtQdnpKNUc3eE90NlJzazFyQkNVYy9BM00zMEs0cmt0Zm84V3ZN?=
 =?utf-8?B?b2tnaEU5aDBKNDJGakJMLzRST0J3NzQxRVEvS29GNDkyYkZPUkFqY08rUng4?=
 =?utf-8?B?dWl6a0dvK2FRMzdTRzNEcW54cE1hd0dOMWhWVVc5Kzc2TitVbW9vTkxJYUN3?=
 =?utf-8?B?Qm1IeVRqazlNbUxGN2JEaklCeDNhcnArbXo2RDFXRnhzdk14M0RQSjhOV0ZX?=
 =?utf-8?B?QTBiRTRsYkxDSEFMeFNGUHlndjU4VDhLc1pYeDdidCtldDI1azJvVzY5cXBo?=
 =?utf-8?B?eHVlRTQ0N05MV1ZScjEvOUc0dHVMSmRzbDRpQmZsaDRCMm5sRU44S21uejNV?=
 =?utf-8?B?Qkd3c3RMam10VlpxcTU3R2tTeVRMNDJhVC9XYW1ENUt2dkk0VDhEYmxrdFVh?=
 =?utf-8?B?ZFErUlM0eTZPSC9rZnhmRUVHSkk3d3hvTmdoU3I5d1pUcUp0Wll1SVg2NmJP?=
 =?utf-8?B?QmdrOCs2a0pKQm95TjF0VGpxTjdld1k4ODM5cFd4cmxXaC9HNjZKVjFybElV?=
 =?utf-8?B?UjV2TlB3T3dudThaUnNibEE2dWw2UWZpdUNRU1RzaDdBWHluNElCSXM5ODhD?=
 =?utf-8?B?c2VwMldyZHdmeVVmazdLNGkzU0pkNnlmU3pKN0VoOUZLLzFmSjJLeFByVktj?=
 =?utf-8?B?cHZ5ZGs2d1dBeXFsa0swVmZVREt3VE85TTFEdUZoNS85WWU3Y3NPZWxFV2lG?=
 =?utf-8?B?QTY2RVoyMHhpMGpMaW5sT0I4MXR2MXRNN1BINHU5NHJzMmJXZTJsYzBrT09H?=
 =?utf-8?B?M2xVcXlTbzE5VDl2T0lBWjFOd2tIN2dIR2plUmZxOS9wSmRKSU81OVUvem82?=
 =?utf-8?B?U2RSWFVSS3pBaUJDSTVBbVJ1anBkVDlONmx0cGJUbmQrcmZHaWdiUTZGUkhK?=
 =?utf-8?B?TDdjZCtPZXBpV3NYVjh3Q0Y1dTBIYjVIUXIrV3FEYTFiNklpem1kMjY1STNR?=
 =?utf-8?B?VTJ0TDdTZTk0cGVNNGtSQng1VVFzNjBGNFg2amNKYk1jVnM2bXRqMGZCNHAx?=
 =?utf-8?B?VXhXdHhSNE85amthQ1Q4S2dSZWlzYnNoN1RNa3VrMDF6L0dSa2tDZ1ptS2Vs?=
 =?utf-8?B?NXluZjJZcTc4YmlZZFMrcWZZK3lrekZSQmNqWXpNOStLclE3WHFqYjlQc1Rp?=
 =?utf-8?B?OG40R2toRGQ0NWhoQ2lKVnlYanBYOU0wd3dNdHd1L3RIdHhuVFRWMzRyK3FL?=
 =?utf-8?B?cWlab3I5aks1WVZQeUtqNytqZEZ4RzRkYTRoSTBSNHYzaGlQTlQvTzJnUHB6?=
 =?utf-8?B?TGM4STNaeUt3a1ppb1llVEcwUUZHMzk4a3JFcWVmMnhQWmwrMXU1SzNncnk1?=
 =?utf-8?B?b1NWZWN0TFRXaGlrZU92VG0xR1FmOXo5cThqdGwyNnlYbU1GY05Yai9Hc1Fo?=
 =?utf-8?B?cElEVFRvamNJWmRmTmwvTmc5MnpWbFpuT3RkUUc0WTBFT2ZwTThzRXBzd3h1?=
 =?utf-8?B?Q1crSkx3NndkMCthYzBNWG91YlRueCs3bVFvc2I5MEtsTnhlK2Z1c3A2VlBx?=
 =?utf-8?B?UjZPSCszYTVkMzZ0MDBTQnAxVms0ajFVdjBYYS8ySUpLdlFKNjJHUUdPcHZG?=
 =?utf-8?B?Zm1oSDZiSVRYL21xczNSd094ZjIvbDd5R0tlRXQzMVZJcW9ZQjgrS21iOHA0?=
 =?utf-8?B?OGpBczRGMVJtZnhUVS8wSDNRU0FiVkwxRC9ZNG80dHlMOXM1ZmRPVEFwanNU?=
 =?utf-8?B?VHdNSTBHV1B1VlRvM3IwSGt3WlRJeXY5dTVxci9ISVd6WjNDRXR6cXlDckox?=
 =?utf-8?B?UXptZ3FKcTJ1S2ZGNCtJSmhhOTJpLzJVZUphYmJ4WXIxOGlMN3dXcktXd0Ft?=
 =?utf-8?B?cHVsT01VdldTeG1XUTl4VE15T1lmR1owTEtORzZ0SFRIcUlENGpyNW1WWFFG?=
 =?utf-8?B?UUFFVUZuSmdwby81MExVa2xvakFVREZGQVRITlJDazVLMU5RNlI4S1VEQkJ3?=
 =?utf-8?Q?cfIo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5925.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67875162-af1d-4418-9b79-08dab664166e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 08:37:01.5210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xRqpVh9aYdovxtsdAn74pRH1yJmd/qRJsxiwKdPGiVUrQzUBMGdOhODlP8DnNNnI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6928
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEtyenlzenRvZiBLb3psb3dz
a2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4gU2VudDogMjAyMuW5tDEw5pyI
MjHml6UgMjE6MDQNCj4gVG86IEpveSBab3UgPGpveS56b3VAbnhwLmNvbT47IHZrb3VsQGtlcm5l
bC5vcmc7IHJvYmgrZHRAa2VybmVsLm9yZzsNCj4ga3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5h
cm8ub3JnOyBzaGF3bmd1b0BrZXJuZWwub3JnOw0KPiBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBr
ZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbQ0KPiBDYzogUy5KLiBXYW5n
IDxzaGVuZ2ppdS53YW5nQG54cC5jb20+OyBtYXJ0aW5rQHBvc3Rlby5kZTsNCj4gZGV2QGx5bnhl
eWUuZGU7IGFsZXhhbmRlci5zdGVpbkBldy50cS1ncm91cC5jb207IFBlbmcgRmFuDQo+IDxwZW5n
LmZhbkBueHAuY29tPjsgZGF2aWRAaXhpdC5jejsgYWZvcmQxNzNAZ21haWwuY29tOyBIb25neGlu
ZyBaaHUNCj4gPGhvbmd4aW5nLnpodUBueHAuY29tPjsgZGwtbGludXgtaW14IDxsaW51eC1pbXhA
bnhwLmNvbT47DQo+IGRtYWVuZ2luZUB2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5r
ZXJuZWwub3JnOw0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtFWFRdIFJlOiBbUEFUQ0gg
djcgMS8yXSBkdC1iaW5kaW5nczogZnNsLWlteC1zZG1hOiBDb252ZXJ0IGlteA0KPiBzZG1hIHRv
IERUIHNjaGVtYQ0KPiANCj4gQ2F1dGlvbjogRVhUIEVtYWlsDQo+IA0KPiBPbiAyMS8xMC8yMDIy
IDA0OjEwLCBKb3kgWm91IHdyb3RlOg0KPiA+Pj4gKw0KPiA+Pj4gK3JlcXVpcmVkOg0KPiA+Pj4g
KyAgLSBjb21wYXRpYmxlDQo+ID4+PiArICAtIHJlZw0KPiA+Pj4gKyAgLSBpbnRlcnJ1cHRzDQo+
ID4+PiArICAtIGZzbCxzZG1hLXJhbS1zY3JpcHQtbmFtZQ0KPiA+Pj4gKyAgLSAiI2RtYS1jZWxs
cyINCj4gPj4NCj4gPj4gYW5kIHRoZW4gdGhpcyBjYW4gb25lIGJlIGRyb3BwZWQuDQo+ID4gVGhh
bmtzIHlvdXIgY29tbWVudHMuDQo+ID4gSSBoYXZlIHRyaWVkIHRvIGRlbGV0ZSB0aGUgYWRkaXRp
b25hbFByb3BlcnRpZXMsIGJ1dCBJIHJ1biBkdGJzX2NoZWNrLiBUaGUgbG9nDQo+IGFzIGZvbGxv
dzoNCj4gDQo+IFdoeSB3b3VsZCB5b3UgZG8gdGhhdD8gTm8gb25lIGFza3MgdGhhdC4gUGxlYXNl
IHJlYWQgbWFpbGluZyBsaXN0DQo+IG5ldGlxdWV0dGUvY29udmVyc2F0aW9uIHN0eWxlLg0KVGhh
bmsgeW91IHZlcnkgbXVjaCBmb3IgeW91ciBjb21tZW50cy4NCkkgaGF2ZSBjaGFuZ2VkIGluIHBh
dGNoIHY4Lg0KQlINCkpveSBab3UNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoN
Cg==
