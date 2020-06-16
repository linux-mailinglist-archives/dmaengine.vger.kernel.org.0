Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA781FA8C8
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jun 2020 08:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725775AbgFPGbo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 16 Jun 2020 02:31:44 -0400
Received: from mail-eopbgr1300095.outbound.protection.outlook.com ([40.107.130.95]:17536
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725768AbgFPGbo (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 16 Jun 2020 02:31:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WNr13y2ORt16hzGnCVUT5s0JRTGhNKsM8r+1DsXXX6tDdcLap6fBeqWt/B/7ZSOiYhe0QeG5BYd6V0KM7FsrsbPOWTUvjAVT829pm8TfEiD58cfPYKridXtk14ELUN5i/u9wXD/lotu0T4C1jZQ+tyOJInqWkPmxpTJiYPBoKDe65SNflkW1nTErbfNVtHt4ZyTNCx/vltfglqXZyBFwQpsbFLxoJnLlKspLuDs5bbLI0OLKXnfpJCJNPZ33pVchijCDOAgyL3FV+73ksPxdEtmDFVaOqKNQrV/jlPVKN0pIif9b0CHjr7NWSmjReH3aEigFoCOhf1Y7e0fQKNXTyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=efI6N3xhX8T8hHm1Yeu332yn+0joB3CVIf4DzG8t/iU=;
 b=bozZ4lXpGPwwUWWehdO5W3KpzMl64uBqZXwGTYldLkP3ABDmikCK5wcixpXDGnqcFEW2hJGiAyEQGrfCvzABeMtlnQUk1JZxkQ9AR+3k1x8m9fUI/HeA4em5osSeIbSrGKO+HE/3pmEGq0K0SaRSODTBya23Ca6Y3/0X+UmX1lFQw7hjmue0QMHNXuDD0yY+6OVgoTJc5+hHgAsY38OBtoOkVg/gVlWi8Fd1a4S7YUQSGsPnJmEVBViRhZ+7qyMgY/PeA4gAFMMesqM6aOAauU5f0Kv0XMLhjFrjCXKgCZPC39qz7/cUZASerZT/oyhM61DdqQZMZdxU/wndT1BpsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=efI6N3xhX8T8hHm1Yeu332yn+0joB3CVIf4DzG8t/iU=;
 b=aNYQyWhUyPGbaclIoRDbUPfUehE5lqgrISs08/ZZ51HzW8voPT4drU7rIRXnYPoopqzSJf4Ytr8bc6RgNLNHDTVNnJJEpgFtiPgPiGX08DMwfe9lGixnNh9GjgmbC3/RpTRP6iK5mGZJJMlLFlC7y917+Ds1cNSFvZlrdDCWx/s=
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com (2603:1096:404:d5::22)
 by TY2PR01MB4681.jpnprd01.prod.outlook.com (2603:1096:404:11a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.24; Tue, 16 Jun
 2020 06:31:39 +0000
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::2da1:bdb7:9089:7f43]) by TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::2da1:bdb7:9089:7f43%3]) with mapi id 15.20.3088.028; Tue, 16 Jun 2020
 06:31:39 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     "vkoul@kernel.org" <vkoul@kernel.org>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] dma: sh: usb-dmac: Fix residue after the commit
 24461d9792c2
Thread-Topic: [PATCH] dma: sh: usb-dmac: Fix residue after the commit
 24461d9792c2
Thread-Index: AQHWL2V2RkH5colCb0+zPor5o0eqOaja8C6w
Date:   Tue, 16 Jun 2020 06:31:39 +0000
Message-ID: <TY2PR01MB3692DB1B26735A02D8BCAB4FD89D0@TY2PR01MB3692.jpnprd01.prod.outlook.com>
References: <1590061573-12576-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1590061573-12576-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=renesas.com;
x-originating-ip: [124.210.22.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9621c738-45b3-4d28-6da2-08d811beed15
x-ms-traffictypediagnostic: TY2PR01MB4681:
x-microsoft-antispam-prvs: <TY2PR01MB4681A74A26826460DCA75349D89D0@TY2PR01MB4681.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 04362AC73B
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B/DVTCZdd8r05kCXvAgu5zsBp2h9IMnUTy4DyJjbADsEm8BljkFEhUf6WbgrCkD+2XtIc46726l0kuit2zq86wKLHjaFf+AIweTZ9qcIpdLXLIJ7MWkScyUyQJonKRDQL9dA557WHlTdXv4YyHv/XE9s+i1d7wwR6uIYAQeX6uPYAlKCqdT+iEgp0m5mFF2+XiPqa+1kvGnfUvykR4u/GBVJ3jKLkdmbepOSjUg4aMLQKhHv6fo4ejMNTEafZHz6hjS+8kCiFjmST8Zim1HXOPYHJRJss30j83/plmKVmiChazU5j6Qk8tNtMQoiXyk2mpDILWt5XH82Lxdxwgdriw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3692.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(376002)(346002)(396003)(136003)(366004)(83380400001)(8936002)(5660300002)(52536014)(8676002)(55016002)(9686003)(316002)(54906003)(478600001)(6506007)(7696005)(55236004)(186003)(26005)(71200400001)(2906002)(66446008)(66476007)(4326008)(76116006)(33656002)(64756008)(66556008)(86362001)(6916009)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: s+IZVxcRI404DYduKIjqekO2hCjklZwGWX7jq8SHMum7t8xb9ISEUQ/4txdKS3hSWCx7FlIOllG5LKfcBWb1HnQedcECVdvicAQN5seL8lNFRHwUF1fkPc7xx8VMG1KoIsMABCaHowtn6cq+NfcimtOOfhTGz+4FjE/2z/gSBnxDa72HSYUj2ywKwh8K7Cm7BrQfOvSThVj2QtblpD+j2uW7Wi6cRBO8dZ75u08xplVLni92gCem8F4OiWXxP3HF0YIInmmOfSEMXQEa+ikGT4OVxU6eyvRs+mpn+LV74h5SGW7JDNdwBH58cbqH0UFP6Aw66yF17sMm2VDITYfQQoL+s+Hbi2JCs0PtYIdl3nY3A2JKHYMqVBCeRQuXX7MOHr53t8csy6UYzy5ojyPrG8nHcW3TJxX9HnBWpAfqy87BWiBdJeuPE8HlIYVECJ5I92lbanXJlMzDG8MQQmYLaQxgA53ywdPeAN05D02OTHbYXq7aJ0cZqM8QHzQihnyK
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9621c738-45b3-4d28-6da2-08d811beed15
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2020 06:31:39.1048
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dbYmhLTgLyNQ9z8VK+xAbNg6rD0jTGr1sMzZfrQQAYtSBsBkloPCOLZcEnz0dtB7yU4Qj0ivUAg2IvMzpUrbLrN7g45oolguV9/C6D4CbXFUNTk8QMAhM3/Wss9CenLT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4681
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

> From: Yoshihiro Shimoda, Sent: Thursday, May 21, 2020 8:46 PM
>=20
> This driver assumed that freed descriptors have "done_cookie".
> But, after the commit 24461d9792c2 ("dmaengine: virt-dma: Fix
> access after free in vchan_complete()"), since the desc is freed
> after callback function was called, this driver could not
> match any done_cookie when a client driver (renesas_usbhs driver)
> calls dmaengine_tx_status() in the callback function.
> So, add to check both descriptor types (freed and got) to fix
> the issue.
>=20
> Reported-by: Hien Dang <hien.dang.eb@renesas.com>
> Fixes: 24461d9792c2 ("dmaengine: virt-dma: Fix access after free in vchan=
_complete()")
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

I'm afraid, but would you review this patch?
I confirmed this patch still can be applied to v5.8-rc1.

Best regards,
Yoshihiro Shimoda

> ---
>  drivers/dma/sh/usb-dmac.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/dma/sh/usb-dmac.c b/drivers/dma/sh/usb-dmac.c
> index b218a01..c0adc1c8 100644
> --- a/drivers/dma/sh/usb-dmac.c
> +++ b/drivers/dma/sh/usb-dmac.c
> @@ -488,16 +488,17 @@ static u32 usb_dmac_chan_get_residue_if_complete(st=
ruct usb_dmac_chan *chan,
>  						 dma_cookie_t cookie)
>  {
>  	struct usb_dmac_desc *desc;
> -	u32 residue =3D 0;
>=20
> +	list_for_each_entry_reverse(desc, &chan->desc_got, node) {
> +		if (desc->done_cookie =3D=3D cookie)
> +			return desc->residue;
> +	}
>  	list_for_each_entry_reverse(desc, &chan->desc_freed, node) {
> -		if (desc->done_cookie =3D=3D cookie) {
> -			residue =3D desc->residue;
> -			break;
> -		}
> +		if (desc->done_cookie =3D=3D cookie)
> +			return desc->residue;
>  	}
>=20
> -	return residue;
> +	return 0;
>  }
>=20
>  static u32 usb_dmac_chan_get_residue(struct usb_dmac_chan *chan,
> --
> 2.7.4

