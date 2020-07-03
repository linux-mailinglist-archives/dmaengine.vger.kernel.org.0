Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 780A7213471
	for <lists+dmaengine@lfdr.de>; Fri,  3 Jul 2020 08:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbgGCGrO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 3 Jul 2020 02:47:14 -0400
Received: from mail-vi1eur05on2084.outbound.protection.outlook.com ([40.107.21.84]:6241
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725764AbgGCGrN (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 3 Jul 2020 02:47:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=II7a2vlWQcU+ZUWRluVqXpAPPzgy3Z/XITI0IWMr1bFFD8bpSIODrX+Z9nxABWrFUMqCfu9H0YtsKDLC8nRTf0w4MUw7QvdzkaXUABB9tDrXZmpJA2ZCHYa7FYOq//DD/n3+E8s8sWpWA5txX67M9RfuYKUl1/FHXDPSdb2hSJLLuMNTZydenGDzzs6AgJNSmQsapPfyCArHyFIgUUVgZUXZ+xwm+4T609/a5oD9/ZU5fqPFXR+KqYPjDfStU9nAChnZapFbKRUg/jPKxRggP6agk/ChSgWsaKHInmGz3Hh0PXyFEkWitDbLYq6+bxKr4cbBmH8QsUB024lBp/BV8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pcn6Lfo7GXue8Y2EOlEaGzd/6dT6auoOqa2D5NYPT88=;
 b=jWuMtDYJU7CGe+xYW/5WPXlrZpMzPuN/86HIo4ET0b7N4ZqoLWZsyqM3DY+L9DSIvwb0OQ0lML7mzVlU1o7f46Pq6HKd7n23fCp4wqcFYXjDQ+E/QvmRfG3mbiHv26DK3zFRkmvyxVrRkWADWNeJnjXOqmvzfi/AE1OP0gZN8lEA4371BxVtm54V1LmQmzDw+KGfUggrfQY6ppHfFE93oY0cT4ZUmZKvlHMLQCQWxTAsfDXecBJDyLqZFic5sw823ExdINyy0aFISnrvp52wXidPYWBYWqPY4U+2cxI4m5Y4axrek+xq/D0i046V0S6dJ3xK29aZWbEL2wDD3YB8xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pcn6Lfo7GXue8Y2EOlEaGzd/6dT6auoOqa2D5NYPT88=;
 b=IjuaE0NiKkACVF+3G2EKc3iPT2tRjPoegRATElxrNB5myA0gv5pQbPFQX9eeCNh6AwxuukHA+9CeDojTX/PE2tJ2zVMAvPV+kQTILQpg7//rWdPLLI65CHmhFTr304ZV+0qV5G6IVa2cz0B7Hf+WWJquUBhWVO9k4ZDUYXPi0cE=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VI1PR04MB6944.eurprd04.prod.outlook.com (2603:10a6:803:133::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.22; Fri, 3 Jul
 2020 06:47:10 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3153.028; Fri, 3 Jul 2020
 06:47:10 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     "will@kernel.org" <will@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "angelo@sysam.it" <angelo@sysam.it>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v1 6/9] dt-bindings: dma: add fsl-edma3 yaml
Thread-Topic: [PATCH v1 6/9] dt-bindings: dma: add fsl-edma3 yaml
Thread-Index: AQHWUD2UfgY/OyAFWEGPjxgSWoXDgqj0x1SAgACjMWA=
Date:   Fri, 3 Jul 2020 06:47:10 +0000
Message-ID: <VE1PR04MB66381237ABA9F1D7FBCD8C83896A0@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <1593702489-21648-1-git-send-email-yibin.gong@nxp.com>
 <1593702489-21648-7-git-send-email-yibin.gong@nxp.com>
 <20200702210107.GA1686199@bogus>
In-Reply-To: <20200702210107.GA1686199@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2ea73f79-081e-4119-972d-08d81f1ce90d
x-ms-traffictypediagnostic: VI1PR04MB6944:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB6944A979E5A6D23DD59DF70D896A0@VI1PR04MB6944.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 045315E1EE
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rWHvEqeYTYCJPPEsKssPl2NGE25gv7uzJTMjYDhHuzya4hJ+xEjeTDGWooMcaVKkabfRwTkrSSc/41Io1Pv2FpjSWdFOZhBCWCRNUdefPG/GYqEGP2KsE0GLB8XWY+TYWLUmjCBMUczigb5/dTAOgFvYWm9/85mk99nphwoLnJNkdw6V2NGzdO2FHG5Z2bi6wplM+hoz5OxuQZe/RzmL9ejcpCobwPGxDMTtr/EN/bL01K3aGSbj3a08s5aNBqSoij1o47DnL44+NwiAOllZxKbnmAkUTwizYb57B3msty645P0NEsKDcXaXsWNhNtaA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(376002)(39860400002)(366004)(346002)(4326008)(316002)(55016002)(478600001)(9686003)(33656002)(71200400001)(54906003)(66476007)(66446008)(66946007)(8936002)(7696005)(64756008)(66556008)(186003)(5660300002)(76116006)(7416002)(2906002)(86362001)(26005)(558084003)(8676002)(52536014)(6916009)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: XabqiBPbVR10jvr0ZkxELefNiNybKuJs1+Dfk3xRwz3jRuq0eGbNVybCYwveUs6RR1tmL6ylttwDCz3Nb8JQBT/7teO/RXS+7jL8q3xCIvqFliawqsc/Y1fnyuIWbbLVHWHXyXFnl5iP7t8DbJ/a2QE0ovDX3Oz844BBXkDlCVSztWEVG+udk/GXHOU9DGDiA7dII5tG4sYUXWR7RKjPige2wnCJPlpcqz3LcR2oii6CVOrZ+Ef96xsF6DOIElnegW56w3ffI9JNcNMjCytNEPxf27BDHOeRsEZ3h7G48+YnZ+Eh7TDLw4HOkw7gixmHEd1PVBA7dQl4IsgJVms3bgTEO75GL2kOeoCGb6w2G+7lcf9C734/VFK4MYwufMDemQBPUbOIGxp+13CFTCy3B9SI7hjNvI5vIvzpP9AGrH22SYOc9hyBE4DOfBX0WrYtNUtrvQwaEyOgJE4iYGfcQX+xe1GtpUbISovdBoAzkLQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ea73f79-081e-4119-972d-08d81f1ce90d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2020 06:47:10.0693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6oIWcoycRDBB/BYph5TIx3Mzabh8LQtLxZj7cd4G4xG469uCWQfPjUIzI7mcaTsgcfB9qm04nzk1RNUAHlGEyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6944
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2020/07/03 5:01 Rob Herring <robh@kernel.org>
>=20
> Please check and re-submit.
Thanks, will fix it in v2.
