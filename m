Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD0971F7231
	for <lists+dmaengine@lfdr.de>; Fri, 12 Jun 2020 04:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgFLCZ3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 11 Jun 2020 22:25:29 -0400
Received: from mail-eopbgr140052.outbound.protection.outlook.com ([40.107.14.52]:33766
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725796AbgFLCZ1 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 11 Jun 2020 22:25:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R6EWx1aRFsOF7S5OhVmM6M6u+x+lWB/eG/VsuG54e/smPOZ9YRSYagpJAz/3wwbMMA173tNweYInPAM1Kw75jWrRpYGqmaGQUTRtx/ZAEoBqJXiLqrNorXII+YmnM7ASLDp4v1FUtbJQ+QO8QRRKq1DIhRI/DUVCgTVcuRXUF0haIpjip1SOt82e7K9MD8j1at0zlAiadn7NP93C3NGRkkE7egWXinLDu8N3iYCK8aVDG5mPX5UxmtC+dINOclE2nJ+KIEJrly9HCEuH4qJHutQHokGab+cqeXO68NVeziRrCO619lM0LMjVd6Y06+9xUcL3Eez2708G1Os+hRclCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwuyytll5DDwJ1AE++igA92l489p9yRGrCwzd82KgYA=;
 b=lXKiyFpEt0zR+31BCHJEE1jvVJ3iwpi3/lHQxhRRsHS/GwFBvk6Z2HslirrRMarBXD6GXfB1dTEl7/nI5eimtqV6Y+bFdeJkOsPpD6OFbaJad8ovpifK3ZX2wf5pGdnHFXZk72yW7qIq2Df7XVhw9N3KTRQt2auz6ozQ8YeLmlkzH1cieuKp6OwI8WO6dBrjsaTUhM2uqLPr4nntTSOWgArDqyEGyCjS6QxNGkgq5UuHFMYEExE0zJluzLLteOP++wsQdM9P4PBvH+Y4t9EePB0YYMlESawmcGbjFGz3qUgyjNTpwYmzVt55DeY+FeEaCRH9d8uhhGs5qgimeIKCWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwuyytll5DDwJ1AE++igA92l489p9yRGrCwzd82KgYA=;
 b=IyehKfnSG3l57MkURLqfxZXtu6lGMn7puPBXhYgD5R+l0ljVrb7rpKSiWM11/cNrDWLcaMvDdznORyZXGNQD4d6ISO6pAxDYqy2p7EvZFquVK33tVY0cmFmLeA7WNfL1z9uxCZj3fyo1WCLjQQQ8aHXGLvVAORzcYgZ8r/ALUcM=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6352.eurprd04.prod.outlook.com (2603:10a6:803:129::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Fri, 12 Jun
 2020 02:25:23 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3066.023; Fri, 12 Jun 2020
 02:25:23 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Peng Ma <peng.ma@nxp.com>, Fabio Estevam <festevam@gmail.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] dmaengine: fsl-edma: Add lockdep assert for exported
 function
Thread-Topic: [PATCH 1/2] dmaengine: fsl-edma: Add lockdep assert for exported
 function
Thread-Index: AQHWP+pTL/vNe9LSdkC2zrFncJYm2qjUQMKQ
Date:   Fri, 12 Jun 2020 02:25:23 +0000
Message-ID: <VE1PR04MB663853E48FC2DA385134C66A89810@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <1591877861-28156-1-git-send-email-krzk@kernel.org>
In-Reply-To: <1591877861-28156-1-git-send-email-krzk@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d783d9d3-1fe4-44f3-4cca-08d80e77dc71
x-ms-traffictypediagnostic: VE1PR04MB6352:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB635267D32D0660F73434E93E89810@VE1PR04MB6352.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0432A04947
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nAmmFLsaAhouKw3khdQ/1UVnXwysdVVHm29xEaX3Nx2gw6hrw/PVOZjsgTrkZ/hlOFqlgZ+ayurxUdy9e/Xplm/Ow1Pyx7AAWmvlMy0OpGaCO5sAMgZmmkScpyFpIzK1DDzeEX+HlOWqdpHgvBzYS5QtDeYJpqZOXVGB4pPTdXa2ZXUGTUnlaC0d6xy6Ss2QXhx1/WKf7gcIfWi4MqR6RSMVGnQVOv01Ghte+IRLO88o4fyKxtIvoN09F48ejZgPRUNiWqvxrRCTOscszRelRWWDc4Us+EkYwM8F74gh3TGVqONKcKPyCTY/tcW/g5Mu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(396003)(136003)(39860400002)(346002)(110136005)(2906002)(66556008)(316002)(5660300002)(7696005)(64756008)(53546011)(66476007)(9686003)(6506007)(71200400001)(66946007)(66446008)(76116006)(33656002)(55016002)(83380400001)(4744005)(186003)(26005)(8676002)(52536014)(478600001)(86362001)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: WOElsHVQIIqNT0G/5NUH2mIn7uo84tlBwoF2fuwQ41RJuBxM6ay8akYFqwJjhBiQJHs1ZF5gaGCLRy/11/QhS0k0jJQuuCMPqHxgYHd7C5tvuuvXBLGlWI79s7gLishoWEyMejQiCH3M+0U7f/nf4EbdrMY8K3KVFDKVVReBdgW6rPZOCjcVXwcNbI2KSEWXt1xbJvYztNTBAd+YKRerKZb0C1B8F9YWBjCHY/CMeKwGGk3zSz5lxuT0eSLa4QXPPDjfRaJ09/Q8Vay3AOuu2DdSZDt3RW44p9ZiVt5ZSBsbqXzyn8RhYqIHbaXGhmcv2n1TNCwf7z+W4mfEQNgP+llv4aYElwMy2ZqgMMPk0kM3NynFvMom8/l8z4oQzJHJOp37EnTKeYuPAFcNq80ki2AeFj5xXcp0tLcLANO0rSwI/IvSCVMVlHeV+vT5hYHlTJAwZKydmz2nKEMT3aSkJusQSI0J8GXqxhJE1WX3QYA=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d783d9d3-1fe4-44f3-4cca-08d80e77dc71
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2020 02:25:23.0837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /+UQVWm82z8Kz0uilLjSliS4/vag7mtsOkye02ciVpSofeJ8nqxVPD26HXF3uOBopX1uZK2Xv4J6UjYr3xze0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6352
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2020/06/11 20:18 Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Add lockdep assert for an exported function expected to be called under s=
pin
> lock.  Since this function is called in different modules, the lockdep as=
sert will
> be self-documenting note about need for locking.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Robin Gong <yibin.gong@nxp.com>=20
> ---
>  drivers/dma/fsl-edma-common.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/dma/fsl-edma-common.c
> b/drivers/dma/fsl-edma-common.c index 5697c3622699..4550818cca4a
> 100644
> --- a/drivers/dma/fsl-edma-common.c
> +++ b/drivers/dma/fsl-edma-common.c
> @@ -589,6 +589,8 @@ void fsl_edma_xfer_desc(struct fsl_edma_chan
> *fsl_chan)  {
>  	struct virt_dma_desc *vdesc;
>=20
> +	lockdep_assert_held(&fsl_chan->vchan.lock);
> +
>  	vdesc =3D vchan_next_desc(&fsl_chan->vchan);
>  	if (!vdesc)
>  		return;
> --
> 2.7.4

