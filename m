Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 899731A971A
	for <lists+dmaengine@lfdr.de>; Wed, 15 Apr 2020 10:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894826AbgDOIlh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Apr 2020 04:41:37 -0400
Received: from mail-am6eur05on2042.outbound.protection.outlook.com ([40.107.22.42]:31712
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2894803AbgDOIlc (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 15 Apr 2020 04:41:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0QPiLQc3yWt5+5JODoKudYptPjcWka5/+wsiq2igoWA1MxhbnmeO/MWKoJ1br86BwSQlpNHN0skDJvyRWnSGH+yNdy/9yxQ64Rsf+WabNyYBGObw1XSYtl/Gr0imMOi9lYOLrmNTuocCJAZtLkO8CsALdiTOjsw5f47ENMIxI/ELZnwUc6Pt+9uoVOkY+Jm8WFWUE8z/I09POGNlDVEknsWT03UhqHKeRiorEmJuWypKIukIsz2uSaOPNRHdZg/UjJKhzd6MBkjEZuc3d67eNn4tgKiW8EB16UbajLv6RBDt5IkJ6O8UZuXd6yq1yqYFi0n4/vceHxir4cv8EtDYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGGYagvqYonO9jb6cCJ4IeLj5zLHwvX2kLs45DplF9U=;
 b=Ym9Eo5yrjKX4ZxdZTdLokPUMprwqhxckEBY6YJwIuM0B4e/Mmqp46mwBG/fVLdGKVzcNTiptEfKJAe7EpuI+xMhOjrHwjAl43Am5o10/zt8bc11FsgufFGAY99yq5cRCcA1FQx+Pb9H3+pORk7st+V/u9i/oYGyuK4ztUqTPWvhbHUZabZwziCHWiGApQbdysyi3nK2Cs65vdaKjKwIC8uz31kNY+e63GTUr75VxXhbMoJ22xZGKnIrDoGPRTbDrn0Uz0ACsn5xRU0/1voCQr+WL570fyso3cJ3Au5dTpiYRan6hnW/VoyMprwd3RPxm3UjdWq3dvLkwy0hVIWodTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGGYagvqYonO9jb6cCJ4IeLj5zLHwvX2kLs45DplF9U=;
 b=BzkbGzXhpiAJVoeSFXPiQ3+f5efDsPIBpC+NQQh5NQxt3KRj2fl6Mc6+YhYgmLkn1zHNqGYCtewTbN9a63Urn36Jn+NBQAR6tNIyn0EmN4RnG66k59h3BTN/exFMB/b8OjzErWk59k5BlDMUg6B2TEvITWYU+qAF3nyFblDtl3s=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6557.eurprd04.prod.outlook.com (2603:10a6:803:129::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.16; Wed, 15 Apr
 2020 08:41:18 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::d5f0:c948:6ab0:c2aa]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::d5f0:c948:6ab0:c2aa%4]) with mapi id 15.20.2900.028; Wed, 15 Apr 2020
 08:41:18 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Robin Gong <yibin.gong@nxp.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "martin.fuzzey@flowbird.group" <martin.fuzzey@flowbird.group>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v7 00/13] add ecspi ERR009165 for i.mx6/7 soc family
Thread-Topic: [PATCH v7 00/13] add ecspi ERR009165 for i.mx6/7 soc family
Thread-Index: AQHV93/7B768gsXihk2i42KIYKNYiqh6E8wA
Date:   Wed, 15 Apr 2020 08:41:17 +0000
Message-ID: <VE1PR04MB6638AE84CD338AE1CF26FDFD89DB0@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <1583944596-23410-1-git-send-email-yibin.gong@nxp.com>
In-Reply-To: <1583944596-23410-1-git-send-email-yibin.gong@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fd1e24be-f857-4ef1-ba6c-08d7e118c41f
x-ms-traffictypediagnostic: VE1PR04MB6557:|VE1PR04MB6557:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB6557FA07ACEBAB897FE21E3A89DB0@VE1PR04MB6557.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 0374433C81
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(376002)(39860400002)(136003)(366004)(346002)(396003)(478600001)(26005)(71200400001)(81156014)(7696005)(7416002)(66556008)(66476007)(66946007)(53546011)(64756008)(66446008)(6506007)(76116006)(8936002)(186003)(8676002)(54906003)(5660300002)(110136005)(52536014)(4326008)(966005)(2906002)(316002)(55016002)(33656002)(9686003)(86362001)(921003)(1121003);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /kvC95EK+kKjD6LaKk8X54FJ3oYiHPaGfsHfJKufc9Y7K9y3uGx3CPpgPCSfQPl7gKj+gMiN01jopZe7CPykcLYa9TuTGu+TQGzH7U9st3jMianrrXMEoXO81XHtinEPqZoAqia6CunTiBIKDUeMYT2s5+eePbb5/lGQLDWyoy/bpN/hezbKSAqez48JaSiWRjFZC1+m3TBLctCZJX/fwI0tnKMgKo7tHEpatOB80nJEDBIhB/6eU1NJ9Su8JQqgdKaASrR+vY+1WFmjjJQdeSEVT9j02yLHrPGvGtTBcW2K5RTLQScmEUh4n8849YocxXDZY29Q2pqIvycSTMFidPVnrrigDB8pagYdO29lCDGP3NbzJvI2nXkfVpA816Wpa0QV+ME2KqH4wogq8g/GEelCGYxLjfLp4P+Bvg28obxfcRbh6kBLKeqTnPHpRMEOyW+3qVY6exUgXSJGKhF2NX5ZMbyJ/575hz6tugnBB1rs0jpnXRi6JYAifH5yAA8KqM1dK7YKcr9m3Fy2xBYzSk73xtOb7gjX18bWQQiZvOKi0Arkyc7TM8ctYjr5BOQabNbnVsHhaBOtDUnDX5LU3w==
x-ms-exchange-antispam-messagedata: BIvNf3AgOsGh1/pjEdAVGTY9PPR4CmIdI/Sae5g4Km7785nfY+zPDvrNXKadPswjvpksHRw8k1lnFiErJtE5dM0heyXmsN6naF/pFrAvJ4d4NU4T+v2wWWwzPB0su/znh0es0etIefn2nZWIK2aDAQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd1e24be-f857-4ef1-ba6c-08d7e118c41f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2020 08:41:18.0154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zsZBj1M5MDP0LJ0fcmLNWZyIqo+u+6JW6r+x1wbipb8A/GVlM6P7gDWjJTAXeM+BlvUmx6GV7uazWVxKWDxKUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6557
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Ping....
On 2020/03/11 16:35 Robin Gong <yibin.gong@nxp.com> wrote:
> There is ecspi ERR009165 on i.mx6/7 soc family, which cause FIFO transfer=
 to
> be send twice in DMA mode. Please get more information from:
> https://www.nxp.com/docs/en/errata/IMX6DQCE.pdf. The workaround is
> adding new sdma ram script which works in XCH  mode as PIO inside sdma
> instead of SMC mode, meanwhile, 'TX_THRESHOLD' should be 0. The issue
> should be exist on all legacy i.mx6/7 soc family before i.mx6ul.
> NXP fix this design issue from i.mx6ul, so newer chips including i.mx6ul/
> 6ull/6sll do not need this workaroud anymore. All other i.mx6/7/8 chips s=
till
> need this workaroud. This patch set add new 'fsl,imx6ul-ecspi'
> for ecspi driver and 'ecspi_fixed' in sdma driver to choose if need errat=
a or not.
> The first two reverted patches should be the same issue, though, it seems
> 'fixed' by changing to other shp script. Hope Sean or Sascha could have t=
he
> chance to test this patch set if could fix their issues.
> Besides, enable sdma support for i.mx8mm/8mq and fix ecspi1 not work on
> i.mx8mm because the event id is zero.
>=20
> PS:
>    Please get sdma firmware from below linux-firmware and copy it to your
> local rootfs /lib/firmware/imx/sdma.
> https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.g=
it/tr
> ee/imx/sdma
>=20
> v2:
>   1.Add commit log for reverted patches.
>   2.Add comment for 'ecspi_fixed' in sdma driver.
>   3.Add 'fsl,imx6sll-ecspi' compatible instead of 'fsl,imx6ul-ecspi'
>     rather than remove.
> v3:
>   1.Confirm with design team make sure ERR009165 fixed on i.mx6ul/i.mx6ul=
l
>     /i.mx6sll, not fixed on i.mx8m/8mm and other i.mx6/7 legacy chips.
>     Correct dts related dts patch in v2.
>   2.Clean eratta information in binding doc and new 'tx_glitch_fixed' fla=
g
>     in spi-imx driver to state ERR009165 fixed or not.
>   3.Enlarge burst size to fifo size for tx since tx_wml set to 0 in the
>     errata workaroud, thus improve performance as possible.
> v4:
>   1.Add Ack tag from Mark and Vinod
>   2.Remove checking 'event_id1' zero as 'event_id0'.
> v5:
>   1.Add the last patch for compatible with the current uart driver which
>     using rom script, so both uart ram script and rom script supported
>     in latest firmware, by default uart rom script used. UART driver
>     will be broken without this patch.
> v6:
>   1.Resend after rebase the latest next branch.
>   2.Remove below No.13~No.15 patches of v5 because they were mergered.
>   	ARM: dts: imx6ul: add dma support on ecspi
>   	ARM: dts: imx6sll: correct sdma compatible
>   	arm64: defconfig: Enable SDMA on i.mx8mq/8mm
>   3.Revert "dmaengine: imx-sdma: fix context cache" since
>     'context_loaded' removed.
> v7:
>   1.Put the last patch 13/13 'Revert "dmaengine: imx-sdma: fix context
>     cache"' to the ahead of 03/13 'Revert "dmaengine: imx-sdma: refine
>     to load context only once" so that no building waring during comes ou=
t
>     during bisect.
>   2.Address Sascha's comments, including eliminating any i.mx6sx in this
>     series, adding new 'is_imx6ul_ecspi()' instead imx in imx51 and takin=
g
>     care SMC bit for PIO.
>   3.Add back missing 'Reviewed-by' tag on 08/15(v5):09/13(v7)
>    'spi: imx: add new i.mx6ul compatible name in binding doc'
>=20
> Robin Gong (13):
>   Revert "ARM: dts: imx6q: Use correct SDMA script for SPI5 core"
>   Revert "ARM: dts: imx6: Use correct SDMA script for SPI cores"
>   Revert "dmaengine: imx-sdma: fix context cache"
>   Revert "dmaengine: imx-sdma: refine to load context only once"
>   dmaengine: imx-sdma: remove dupilicated sdma_load_context
>   dmaengine: imx-sdma: add mcu_2_ecspi script
>   spi: imx: fix ERR009165
>   spi: imx: remove ERR009165 workaround on i.mx6ul
>   spi: imx: add new i.mx6ul compatible name in binding doc
>   dmaengine: imx-sdma: remove ERR009165 on i.mx6ul
>   dma: imx-sdma: add i.mx6ul compatible name
>   dmaengine: imx-sdma: fix ecspi1 rx dma not work on i.mx8mm
>   dmaengine: imx-sdma: add uart rom script
>=20
>  .../devicetree/bindings/dma/fsl-imx-sdma.txt       |  1 +
>  .../devicetree/bindings/spi/fsl-imx-cspi.txt       |  1 +
>  arch/arm/boot/dts/imx6q.dtsi                       |  2 +-
>  arch/arm/boot/dts/imx6qdl.dtsi                     |  8 +--
>  drivers/dma/imx-sdma.c                             | 67
> ++++++++++++++--------
>  drivers/spi/spi-imx.c                              | 61
> +++++++++++++++++---
>  include/linux/platform_data/dma-imx-sdma.h         |  8 ++-
>  7 files changed, 108 insertions(+), 40 deletions(-)
>=20
> --
> 2.7.4

