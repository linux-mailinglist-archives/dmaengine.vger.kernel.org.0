Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFF86B3620
	for <lists+dmaengine@lfdr.de>; Mon, 16 Sep 2019 10:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730822AbfIPIDd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 Sep 2019 04:03:33 -0400
Received: from mail-eopbgr00068.outbound.protection.outlook.com ([40.107.0.68]:44344
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727374AbfIPIDc (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 16 Sep 2019 04:03:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wrk/aRXqc7Ki0rjY0K2kUOktreEdiNhNuXM78Q3Sdy7cjdqea72h8EKz5UAvSw44icswJY0c67lPS09j83bXFkfc6wsSdZjwX0HMzSBH5ttauKB6XCozulp4Hpw4kH4xSR83F7IvEww0yO5PNR7yNZda/hR0xlM4RXqZY4dlZ4Ab03TsWtkn6LNdn6KA/h86mQLWQo7WDu2QlMm59Mnb0jYvTFlDM6wRjImDXHQtGTHm7R8+YHCWBKtgse/XE3nmFAKL72ATa0pYtmvfVMAbqjoepv9Eo6eNqz8nbl1BZzOf78ZulhDXL5SctDfuvM7jFwZtWiKDnyLgS+NTFU2Evw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KPuvN+kDylNI+qUnXmqbN38GKnIwxTl7w0MidEyAfZs=;
 b=mbS8WmjfUeaaCrVboyS9XwYCprgR132Ureb+Yi8d4NLXu+eeRdnKghAu7+1rIQjnXpE2LYzV8KayWaPlpurK6oHIWhV9VhhDPOwQJJTNjbgQTad3JrxJJXikqZjVmZGd35VRY04sDSzkGZCah4LiZPxORsV0sRYJBz9wAlHhgSCSD1y7eObk6Yi8fepDjRU1eA34NHp5xiq4qsc+oSBwju1nKbVdP+rlguQVZb8He6o6ChoktT8QOvimiO0fnj7A9c99RcC9kDzOof80lcVtJWagZI9tkzawmvZYPf4FQ6J/kthivUM9PKj1KcEIpshB2/I+oxnqGHXESByWcaUjGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KPuvN+kDylNI+qUnXmqbN38GKnIwxTl7w0MidEyAfZs=;
 b=gIeEnxG4OfwlNUxRQcs/5rjo4UY+fVo6+gQZULr0dQwk3lB7qK6jgrXt4QTSLZKcaoNl+Hw5jNND35R1KtNMSShrANI/LiBzq80MdMBq8ilM3NdQnwDNjt/SFwxWiDjFL0xVH3gDhQCAR34NbkkSIkvEDUY9REKDeZJcc5vqrtk=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (20.179.235.81) by
 VE1PR04MB6496.eurprd04.prod.outlook.com (20.179.233.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.17; Mon, 16 Sep 2019 08:02:49 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::c8ae:f1f7:b7be:5976]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::c8ae:f1f7:b7be:5976%4]) with mapi id 15.20.2263.023; Mon, 16 Sep 2019
 08:02:49 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Philipp Puschmann <philipp.puschmann@emlix.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: RE: [PATCH 0/4] Fix UART DMA freezes for iMX6
Thread-Topic: [PATCH 0/4] Fix UART DMA freezes for iMX6
Thread-Index: AQHVaLAxu2UDdwNxk0eJG3Q3r0yNHKct9iKQ
Date:   Mon, 16 Sep 2019 08:02:49 +0000
Message-ID: <VE1PR04MB66383FAB08506993B305AC8D898C0@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <20190911144943.21554-1-philipp.puschmann@emlix.com>
In-Reply-To: <20190911144943.21554-1-philipp.puschmann@emlix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 33c64e22-a496-4e98-a413-08d73a7c446a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VE1PR04MB6496;
x-ms-traffictypediagnostic: VE1PR04MB6496:|VE1PR04MB6496:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB649679AD6CFC9D65CB9F5733898C0@VE1PR04MB6496.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0162ACCC24
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(136003)(366004)(39860400002)(376002)(189003)(199004)(14454004)(71200400001)(71190400001)(52536014)(478600001)(81166006)(316002)(76176011)(81156014)(2501003)(33656002)(7696005)(25786009)(66946007)(66476007)(64756008)(256004)(8676002)(4326008)(66446008)(66556008)(99286004)(5660300002)(229853002)(54906003)(6246003)(14444005)(66066001)(110136005)(6436002)(55016002)(9686003)(76116006)(11346002)(486006)(7416002)(3846002)(7736002)(86362001)(446003)(2906002)(102836004)(6116002)(186003)(305945005)(476003)(26005)(8936002)(53936002)(74316002)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6496;H:VE1PR04MB6638.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MFCm1zv4tbzNCiFPQ1W2csUN1IgzUd3fkemEb0fz6qlJchlafWcAiMCeQXZG4vx5R69/b9DsOO+cfnFsm30FT3fIcLoSlqILF5omm9qg5TVVC0k8L339YKIHo5WoTMCkBU29ZoxZ58ZHuSokR59WKtD//nlagtVRx7smd/zTj9/BRegrF1Vi5lhdHALuG5CJIzOvRuTHAKX66F9u90ttLoMmSy7YkPpv160ZMMCGPT4PReKPDxw32XCZEtOIr6rvkBqw0JiC2+kKt85swXCvePvuCUoKiEfQWpCOtiMqWjZs0KUnHGUYg4V8W7BMIisyslEt32ZCTcKavY3AVTMzq7C7sGbQVerMwkJvwznqq4qK+LOrTOEfirKeaYmT5qhEKJIvECRnXmQtl+bAUJw1udJJqBUcaLXDgaTK+v5SSZk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33c64e22-a496-4e98-a413-08d73a7c446a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2019 08:02:49.1571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J5iIFzzxLDqPHFAGVJcBV0mc0VHea3IF8mGB7X4Gl9YfBEwIc9NY9osidi5bqObLhkdny33eJ0j4ww1N1+298Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6496
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2019/9/11 Philipp Puschmann <philipp.puschmann@emlix.com> wrote:
> For some years and since many kernel versions there are reports that RX
> UART DMA channel stops working at one point. So far the usual workaround
> was to disable RX DMA. This patches try to fix the underlying problem.
>=20
> When a running sdma script does not find any usable destination buffer to=
 put
> its data into it just leads to stopping the channel being scheduled again=
. As
> solution we we manually retrigger the sdma script for this channel and by=
 this
> dissolve the freeze.
>=20
> While this seems to work fine so far a further patch in this series incre=
ases the
> number of RX DMA periods for UART to reduce use cases running into such a
> situation.
>=20
> This patch series was tested with the current kernel and backported to ke=
rnel
> 4.15 with a special use case using a WL1837MOD via UART and provoking the
Hi Philipp, Could your Bluetooth issue be reproduce on latest linux-next? O=
r did
your kernel which can be reproduced include the below patch?

commit d1a792f3b4072bfac4150bb62aa34917b77fdb6d
Author: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date:   Wed Jun 25 13:00:33 2014 +0100

    Update imx-sdma cyclic handling to report residue
> hanging of UART RX DMA within seconds after starting a test application.
> It resulted in well known
>   "Bluetooth: hci0: command 0x0408 tx timeout"
> errors and complete stop of UART data reception. Our Bluetooth traffic
> consists of many independent small packets, mostly only a few bytes, caus=
ing
> high usage of periods.
>=20
>=20
> Philipp Puschmann (4):
>   dmaengine: imx-sdma: fix buffer ownership
>   dmaengine: imx-sdma: fix dma freezes
>   serial: imx: adapt rx buffer and dma periods
>   dmaengine: imx-sdma: drop redundant variable
>=20
>  drivers/dma/imx-sdma.c   | 32 ++++++++++++++++++++++----------
>  drivers/tty/serial/imx.c |  5 ++---
>  2 files changed, 24 insertions(+), 13 deletions(-)
>=20
> --
> 2.23.0

