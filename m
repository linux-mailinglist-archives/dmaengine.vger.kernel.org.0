Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE701D064E
	for <lists+dmaengine@lfdr.de>; Wed,  9 Oct 2019 06:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730250AbfJIEJs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 9 Oct 2019 00:09:48 -0400
Received: from mail-eopbgr1410105.outbound.protection.outlook.com ([40.107.141.105]:40299
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725807AbfJIEJr (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 9 Oct 2019 00:09:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iasa6/TQGj4NkmQ88H+UfoQfZtBVnUR0XLLccVX3xWNGTGQo7crgJArR5WIlOeL/NyV9LKmftrF5Kg8Pv39Ox4Fs5qI2s1EYqZeG/Bw+qaL7pjiEt2GXTms8YtgoRyr//lv2Lx69cYrYBD4WnVudAtxYUghbbCMjxT9CQHvs2Y1dx6XObgEiZ0cDo74HeJ76Xq77t2dMW9pCcuGyWulOWa4kg5PDzZ2mCmbBgwSbjIYiyjVwKe3IXC3rY42dtJeXJiq3hq2i9jyB9feoFi8oA2vadIqrs07BK5GkO3+Zhs9cY8Qtr6uKjJe5pfGrhDXKsHfaguSftylfo4D0Y3JceQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wz3l2fM2QgycuiEQZxs/la0C6Ob2qDLFq2P+Kwr1DTs=;
 b=CBGA5YL0aF4okKfZpg4/PlHZz5xaBYktmX/jSVVeexoy4HmZn0lC7YpI9ol7Y1cZ8nBIjzzhqLWgcsHpoHAXlkjOXz41npES5A+oIP4AgASYS3PaCJgCXZN2jCwoLgXkFY09COnQ21dRVFTQCJW6Dmb1Eucdl5VruQElfDnBR3+JmUDLlT0lU1EnH1HaoWatQhEpULw6/jZqvm0GhcPOSTgLj0B1fmrGlEgd6M/7vcehRfiXCcFyk/WpgKrPdyGY8pUPKvwL6Whuf5QKDLIBurg8G2UQa27G74jwu36TAqinEOrvFPBVjtmKU8fdJANTj5JHTTfFDSyXBoZqbtZHxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wz3l2fM2QgycuiEQZxs/la0C6Ob2qDLFq2P+Kwr1DTs=;
 b=fgT8epfjNi/iOqgCd0O9UI7tlYFWSTKB+zxL6V8KvUlx5WEgpG/xBtHXFXGMsRzJ6zZry3KbGFNuOGQ2pcMyJBlGS3eSZS16ZLPFOyLYJ7kXzgzonxSxH71zD9KVggpYg6ioU6+XBt4hOtGgvn/voqL2dDl0i51K1zd3U7rqX/A=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
 TYAPR01MB2237.jpnprd01.prod.outlook.com (52.133.179.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.24; Wed, 9 Oct 2019 04:09:44 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::548:32de:c810:1947]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::548:32de:c810:1947%4]) with mapi id 15.20.2327.026; Wed, 9 Oct 2019
 04:09:44 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
Subject: RE: [PATCH 04/10] dt-bindings: rcar-gen3-phy-usb3: Add r8a774b1
 support
Thread-Topic: [PATCH 04/10] dt-bindings: rcar-gen3-phy-usb3: Add r8a774b1
 support
Thread-Index: AQHVfcSoT2S69IEDqUax+AkH1BtR7qdRsplA
Date:   Wed, 9 Oct 2019 04:09:44 +0000
Message-ID: <TYAPR01MB454424D47DDD0A21DD2F9FB8D8950@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <1570531132-21856-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1570531132-21856-5-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1570531132-21856-5-git-send-email-fabrizio.castro@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [150.249.235.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d4835e1-00ea-42ce-f081-08d74c6e8444
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: TYAPR01MB2237:|TYAPR01MB2237:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB2237C6A20378224BF3C8FA9AD8950@TYAPR01MB2237.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 018577E36E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(189003)(199004)(76176011)(6506007)(7696005)(6436002)(102836004)(229853002)(6116002)(74316002)(110136005)(186003)(3846002)(26005)(52536014)(99286004)(81156014)(81166006)(55016002)(8676002)(446003)(11346002)(66066001)(486006)(476003)(71190400001)(9686003)(8936002)(66556008)(6246003)(2906002)(558084003)(7416002)(86362001)(54906003)(64756008)(305945005)(66446008)(33656002)(478600001)(14454004)(25786009)(4326008)(5660300002)(7736002)(256004)(66476007)(316002)(66946007)(76116006)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB2237;H:TYAPR01MB4544.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: le8rJ/vJqQSgRWpVxa1gP06w8/tQqYNg2ntTYFtuMGey71IEtEP9+YXp2H40KskfXXhEJd33LskClAJ4lAn2JkjsdOrAcCwJwdq6nrprYouGzIBfSiavPba15FxJByevdpLGyKT8s2l+x6lUpjQPMYaau4OSLVKaNPBL/gM18tejedxDji0Rla47lh7TPsJOEp4GrzW7geu2vnQThoIIGen0iYtZdVQSxSdiZLJJhRiJdq+L0ii+Nuo4VkU+vt/06+yNvTWCpKmKIITBfVIELP7RMK2hQJxJCbQfO5eqKRuU4Q9TVW5nGXuS8PDOG19cVTxhCDbXaPNERWghb0PaZi7Iu8qYSrAVIPsv/YWiiee1hO9HcpQORgFsVugGIRE+L7son597wUtE+9OXQl94mnxIfhCG2Mc3sqF6NrGgBBk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d4835e1-00ea-42ce-f081-08d74c6e8444
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2019 04:09:44.3719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 684F3Cz0cIIt5veHR9nrKp2782qAqXxptDTUKQN/GyJnKqpU8h7aIFbKKIQUkWpIpItZiOQJqkREV3vWUM/2NRY8NaJycI0ByoAM0IPVjOcOUoerljTSQIPfLK40wgr6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2237
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Fabrizio-san,

> From: Fabrizio Castro, Sent: Tuesday, October 8, 2019 7:39 PM
>=20
> Document RZ/G2N (R8A774B1) SoC bindings.
>=20
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Thank you for the patch!

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda

