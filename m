Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C45D0BEC32
	for <lists+dmaengine@lfdr.de>; Thu, 26 Sep 2019 08:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbfIZGxv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 26 Sep 2019 02:53:51 -0400
Received: from mail-eopbgr60063.outbound.protection.outlook.com ([40.107.6.63]:2087
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725823AbfIZGxu (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 26 Sep 2019 02:53:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jpaP2RedByAnclOeCchuN9wlCK5VfQLRbfgdg34Na+OUQ8L33Qx/nza784LPyw8NK+eoFKu0vz0ifGLaKJHwKafjbQXwxsJ1sTn/jolC9zXPix19sI0n9fH2pHoUZ9iYmTgVL0cToD4S69eYlRTt3WI9nz1UOeBIEIOPqwyM2YOiDSF5ozLPglKtBdZ9bicoGuPOurOy4vIiOLgAMyhTM5g4TcuiF9b7zFtXjFLtQdfKXLZR+CAXWfg8S2pXEpHWEZtzsqvgh+nz9Ru8wXGgKzZl2qF5kGpRQMrUdF2b7YefDWAd3jm97HS/QAUjgmKKA78BsaYYtS5oJDlOEMSz7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnfxxzTQyyJXgDcB8RznhqZK+dxr/9VRA48iiFwTEmg=;
 b=JKy31u9X88Mjd5LiLnSMjnyZhyWzAhxtXWXOGRGkn4qDjKKt6MO/ch/8sXuQu8+brOHRM6+EV4xSruN2DQIdasxo35IApgyq9VOEnJ5My9HrMMAKTwbcc14td/ZkIqfhPX2BxVASrDiDhXkCI32S+baKn+NlCjFBy3Bgpj+eqKFn9414wuwVjrLClGkUlnMzez0/vl9xjMg0UWzzOwDQje0/jnHGg9n8C1rWHccQ4IycPowj9p8CaYssqE12V9hZJ2gDNSw/Z6QG8PC43ErY4XIBNqYP3fZJlpy45TmeFGc15okh1SSkIwXZCIlOGB5nt0BjJbRdZrn5nWsRRFEGSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnfxxzTQyyJXgDcB8RznhqZK+dxr/9VRA48iiFwTEmg=;
 b=DaMHkg3XoQVXEQ94+ZvBpAaHgwmdScdeJXBUp5Iu4xRd45C+aa7/L5bjvmUYCX0AbkNc9rzToFT3u11Knc6cf7/7eAm4iGCuRpq3CvX6Q1nL2MVK/Ck+yOMQkgNZ6g5urf+0mL/0KIuk1YSU1t+cmDt0IHrDPBfIcbHJaHVM8rY=
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com (20.177.55.159) by
 VI1PR04MB5439.eurprd04.prod.outlook.com (20.178.121.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.17; Thu, 26 Sep 2019 06:53:47 +0000
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::e158:ee7a:cebe:5b3e]) by VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::e158:ee7a:cebe:5b3e%7]) with mapi id 15.20.2284.028; Thu, 26 Sep 2019
 06:53:46 +0000
From:   Peng Ma <peng.ma@nxp.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Leo Li <leoyang.li@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: RE: [EXT] Re: [V4 2/2] dmaengine: fsl-dpaa2-qdma: Add NXP dpaa2 qDMA
 controller driver for Layerscape SoCs
Thread-Topic: [EXT] Re: [V4 2/2] dmaengine: fsl-dpaa2-qdma: Add NXP dpaa2 qDMA
 controller driver for Layerscape SoCs
Thread-Index: AQHVIdHlJeIOycgBm02VgX87ZyLFMqarFPIAgHsuGRCAFZePAIAAcoEwgADtYwCAAO/PMA==
Date:   Thu, 26 Sep 2019 06:53:46 +0000
Message-ID: <VI1PR04MB4431AE3E6AEB2AFB3B368F5BED860@VI1PR04MB4431.eurprd04.prod.outlook.com>
References: <20190613101341.21169-1-peng.ma@nxp.com>
 <20190613101341.21169-2-peng.ma@nxp.com> <20190624164556.GD2962@vkoul-mobl>
 <VI1PR04MB443142772665BB29B909DFF4EDB10@VI1PR04MB4431.eurprd04.prod.outlook.com>
 <20190924193446.GF3824@vkoul-mobl>
 <VI1PR04MB44314EF818033EB52D0A591DED870@VI1PR04MB4431.eurprd04.prod.outlook.com>
 <20190925163414.GH3824@vkoul-mobl>
In-Reply-To: <20190925163414.GH3824@vkoul-mobl>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.ma@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f260e3e-5663-4053-70fb-08d7424e4766
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: VI1PR04MB5439:|VI1PR04MB5439:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB5439D15BCFF449BBB15B1275ED860@VI1PR04MB5439.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0172F0EF77
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6029001)(4636009)(366004)(136003)(376002)(396003)(346002)(39860400002)(13464003)(199004)(189003)(486006)(11346002)(5660300002)(66066001)(44832011)(52536014)(446003)(3846002)(9686003)(55016002)(186003)(71190400001)(71200400001)(26005)(99286004)(478600001)(25786009)(8936002)(6116002)(7736002)(102836004)(305945005)(14454004)(76176011)(4744005)(76116006)(66556008)(64756008)(66446008)(33656002)(6246003)(66946007)(229853002)(6506007)(8676002)(4326008)(86362001)(81156014)(81166006)(476003)(256004)(6436002)(66476007)(316002)(2906002)(74316002)(7696005)(6916009)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5439;H:VI1PR04MB4431.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W2Y/vjeCN5asGX/0pOE6nFHhPg98In/iTyDYjjcM0XsT1P9ru51NEZd0m/3SnKozFYkG7ElIPOoG9JcMze0EhBCoo0jk4GZ9TkP2YfNYL9+NJDusUEDjRIgL76UTyWLrJg6K710V7hA/7+PfuD7rgZ5D8zEnhW+19TWHmVuE2EajZgx8c9iiruvjc0XDqT7tePGiUwPCOnq19zPzVpLkgpqm0GjMH2h8JBp317JuajgyN3hPqXaEHZNA2nQ+WlxMkTQgY6lNkjQzigjr0Msu1hal0hTzMf6lsln34lNj5S+3Z+wE9FPIwzqPPAqSG3/jbHTQ+tVoYg4FSHUx+0dmL6SD1uSzu79kdotXHU+BJSUGiXRn8c9XS1fwzZSSRopFrYQHQ3c5OBA6My2S9t3IIDKa0ETJKIYsypNHuWNtMmE=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f260e3e-5663-4053-70fb-08d7424e4766
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2019 06:53:46.6687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 65mYMs+SZy6wyhWQWXcVoLZmHdjRh/Jj2qEcRa1kfzdosZZ3i9u04sKwiyt5+Kc8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5439
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

SGkgVmlub2QsDQoNCk9rLCB0aGFua3MuDQpJIHdpbGwgcmVzZW5kIHRoZW0gYWZ0ZXIgbmV4dCBN
b25kYXkuDQoNCkJlc3QgUmVnYXJkcywNClBlbmcNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+RnJvbTogVmlub2QgS291bCA8dmtvdWxAa2VybmVsLm9yZz4NCj5TZW50OiAyMDE5xOo5
1MIyNsjVIDA6MzQNCj5UbzogUGVuZyBNYSA8cGVuZy5tYUBueHAuY29tPg0KPkNjOiBkYW4uai53
aWxsaWFtc0BpbnRlbC5jb207IExlbyBMaSA8bGVveWFuZy5saUBueHAuY29tPjsNCj5saW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnOyBkbWFlbmdpbmVAdmdlci5rZXJuZWwub3JnDQo+U3ViamVj
dDogUmU6IFtFWFRdIFJlOiBbVjQgMi8yXSBkbWFlbmdpbmU6IGZzbC1kcGFhMi1xZG1hOiBBZGQg
TlhQIGRwYWEyDQo+cURNQSBjb250cm9sbGVyIGRyaXZlciBmb3IgTGF5ZXJzY2FwZSBTb0NzDQo+
DQo+Q2F1dGlvbjogRVhUIEVtYWlsDQo+DQo+T24gMjUtMDktMTksIDAyOjI3LCBQZW5nIE1hIHdy
b3RlOg0KPg0KPj4gPkNhbiB5b3UgcGxlYXNlIHJlc2VuZCBtZSBhZnRlciByYzEgaXMgb3V0IGFu
ZCBJIHdpbGwgcmV2aWV3IGl0IGFuZCBkbw0KPj4gPnRoZSBuZWVkZnVsDQo+PiBbUGVuZyBNYV0g
R290IGl0LiBCeSB0aGUgd2F5LCB3aGVuIHdpbGwgcmMxIG91dD8NCj4NCj5JdCBpcyBzdXBwb3Nl
ZCB0byBiZSBvdXQgb24gY29taW5nIG1vbmRheSENCj4NCj4tLQ0KPn5WaW5vZA0K
