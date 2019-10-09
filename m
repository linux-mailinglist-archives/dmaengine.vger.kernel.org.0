Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35033D0644
	for <lists+dmaengine@lfdr.de>; Wed,  9 Oct 2019 06:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbfJIEJh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 9 Oct 2019 00:09:37 -0400
Received: from mail-eopbgr1410095.outbound.protection.outlook.com ([40.107.141.95]:21825
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725807AbfJIEJh (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 9 Oct 2019 00:09:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=baE5Bp3puhhtOnLq4tneSzR6Ae+vEo16VMQvZcb9+9EReOuqamYL9FjMl+sOz9spzSfmiZxx3VB0Ig0tViVH2BCyh+LGgu6jTRZNDX/6H/TfG13z9L5fOrsJsC188ddZPsHheXMJ4t0K07TJg4bsk2oK7q5SUtn6RrZZ32A/OKZFY6TtKz0E56zBaNDwA2l93DzNHkhAz2nxX9rkg2HdksXn08DtDtjOF2xMZDvAcI3SRx6QHQO/ECPzGC2zuSGnCQSqY5x8nVoTVf7+wU4qx0ZfD7QW9Gn3+z4J+NmWvTE2ohBw8WpTDCH55e9n+QbQigAKVUBss17waOJu29BDiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxAplf+P7NwX22fB2McOQeaFsZAkVU12rbyDdvrew4I=;
 b=kbYY6seuOJW8ZG38yZSjlPHB7N3YZG2+Xa2ZM1llX+4coB68qstfoJgDK6DDoXDH9S583ZbW/I7fIOW5lUvMrjQ7SsqBDD05n0el7FEPVZmf4szH7MrtGaHeBFw/VFcx4HWnBsZRWH9k17qSl3wTYJ9YmNBTaKb5iP1+rsDmbhFvhMuWlQ5i1LDfYKPdPIGyJZiamnuKncwD6yojAVe6VZfZftHkONiB/XaG3mLA1z3ZoYz7Mk6/cVPFQCy7XFJfZZh0va2IN0t9zIHjSxHzfKYbsJAhUBCrLH14EtQBjSRyv4b5QGBelJzdssA4in1f11cGYg2oEJckBkYl+8+JVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxAplf+P7NwX22fB2McOQeaFsZAkVU12rbyDdvrew4I=;
 b=gRVmN8y6oQovhqm6kostO7KwSLRpCjeGr8iTfyUpLZ6Eg7F3u8/Pz+H+ENp0p44OAR+nKniMkJxH9Nx+wZrDPYbXRKScWw16wgENSwx+yy7BhX2aNVGtvtaXN47iCPtQbp+Bi3W6OLkDeoVpi8Hn9Grg9fjc1YJ7iGmhvIUpKxs=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
 TYAPR01MB2237.jpnprd01.prod.outlook.com (52.133.179.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.24; Wed, 9 Oct 2019 04:09:34 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::548:32de:c810:1947]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::548:32de:c810:1947%4]) with mapi id 15.20.2327.026; Wed, 9 Oct 2019
 04:09:34 +0000
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
Subject: RE: [PATCH 02/10] dt-bindings: dmaengine: usb-dmac: Add binding for
 r8a774b1
Thread-Topic: [PATCH 02/10] dt-bindings: dmaengine: usb-dmac: Add binding for
 r8a774b1
Thread-Index: AQHVfcTEmC8GxV6GAkK9yYzYH5Rrj6dRsfpg
Date:   Wed, 9 Oct 2019 04:09:34 +0000
Message-ID: <TYAPR01MB45445654202C1B951641FC46D8950@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <1570531132-21856-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1570531132-21856-3-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1570531132-21856-3-git-send-email-fabrizio.castro@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [150.249.235.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d91b7fe6-c336-4b2c-a2b5-08d74c6e7e65
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: TYAPR01MB2237:|TYAPR01MB2237:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB22373A3B013834B6788F7C4AD8950@TYAPR01MB2237.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 018577E36E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(189003)(199004)(76176011)(6506007)(7696005)(6436002)(102836004)(229853002)(6116002)(74316002)(110136005)(186003)(3846002)(26005)(52536014)(99286004)(81156014)(81166006)(55016002)(8676002)(446003)(11346002)(66066001)(486006)(476003)(71190400001)(9686003)(8936002)(66556008)(6246003)(2906002)(558084003)(7416002)(86362001)(54906003)(64756008)(305945005)(66446008)(33656002)(478600001)(14454004)(25786009)(4326008)(5660300002)(7736002)(256004)(66476007)(316002)(66946007)(76116006)(71200400001)(138113003)(98903001);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB2237;H:TYAPR01MB4544.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: usnzRN2UVo12vSwFj5u7VWBVy0aom9VyhnljXwDoSaWUJnYGUJfiBYLPYcoUPJLwrr6sNDRtqhyoGOwJGODEy+BTGFGlywEGt3HQGgPQ8vCOUIIyT8DCD1OPQ1HTx3JCW84VN8QNhx3aqhk6eXEQMRPpknP9lrCjjRwoLFXJIJaS9RlCu1zH5PFX58MxyBMDwx3eDLQIAgLBo/wU0BHxVbOuM9OtrZ9ui34s8Wu7LzD5IP6jor9MQTYOUobHrI1h78utEvzuGfe3vMLrnpdz97WOU2k+zwJiRZ21eA+VrESlzHtOShFx6WQPvNNkSZQKIRfQtoUCfoqrjaa8JDhdqU+5DYtrbF/WX6g8mfENxvzVf2WTlNZ7ohk2x9bPE+v/bWkPg3+QFjQrvEfG5kcR8+0tBre07JPYpXp/uu428HU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d91b7fe6-c336-4b2c-a2b5-08d74c6e7e65
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2019 04:09:34.5129
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wPCxhW5xfz4CSfBiegig4szh/RJqPhDAh7U8dmA57dUfgy8xNOkqzmxkv3Uve2Z+XnLYTUb3X3bqL8HbxI+I45x+aZuOvJI8OdLzzTFoPclfibfrzgXWZDNjpDIMzl/1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2237
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Fabrizio-san,

> From: Fabrizio Castro, Sent: Tuesday, October 8, 2019 7:39 PM
>=20
> This patch adds the binding for r8a774b1 SoC (RZ/G2N).
>=20
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Thank you for the patch!

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda

