Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E30F39F778
	for <lists+dmaengine@lfdr.de>; Tue,  8 Jun 2021 15:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbhFHNSv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 8 Jun 2021 09:18:51 -0400
Received: from mail-mw2nam10on2045.outbound.protection.outlook.com ([40.107.94.45]:56480
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232817AbhFHNSu (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 8 Jun 2021 09:18:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fN+t9J4jols570F3T4ZtFuryIMWgghqguqls++P5CXYgVMYydbapINH+ahKItXnbqHdQ+ahkj+FXaFUEFqi2Yss2VNtuK/LUWas14qIcf/v8rS0uEE/+NTVtf42aj5lZ927tpn706hX+XQhruShOlee8lfigkNnbalTThtBLoJG6X31hUcOpf7ycvz2I/9xpE2V4V7nzgdz8hIllYdCWxyvvIJ0D4U3/3513TJ2T/I2QK2vBiZ5NNRRbbWKImV2AtDvsZ8Yho0wzbSb9mbBNfo93rY7LPHv0D/TSxkRp+P+/8eYJAeOO6xVw546dkPQh6AggAdhBj8kgosUU20yKyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUq20jTUqH9GEUP9ad6lNT+YAbBSbZ8nFMRiA0mZLcg=;
 b=cGSEtvHapbR5QK5WC5Pbdhe97DgPBykhcfRnE+Ooia3XFFWhp+ftVlLGk/UzZ5gv/a3VhT/TpD1BiClWh54Fzs6EfRrf/N6vQZEQLL/Sr6ANlFrfupzeRhBfExEDigWzKlOBDJud883CEXgRsPcuux4ZmW+a6d78r48cyhPokIhcZiA1bGx1LltGJn5bmNC/+OuzpjxU35bsP6GLpGT1luvKqr2WgJpW4I5I6DEcDX1ImTjNlabzrXAVgVX+7cgR3ih+r7FkAhJa/qkI6FRYEAH3gVRs6mGLhfiAwOXlMB+z/IbfA9Y1ueqAG/WdHXeyxwJAH7ruAnrp90j83tNOiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUq20jTUqH9GEUP9ad6lNT+YAbBSbZ8nFMRiA0mZLcg=;
 b=Lmi7AAlZSboNSo/6EWo6SxfDtm9V1/3oJJeI04NZ6pNlMkoJVvJJlkEL2wXF6pzfz7q9ZntSA02i1qO7OA1Z5gv4Lg5SVL3nYFC+VFp7Ulv8fwbJyGMZFM9VZbEoXYr4pToTWZl3BglEmrOu9OrrmYVxd4ewVEYudE+IhzsJNQQ=
Received: from CH2PR02MB6523.namprd02.prod.outlook.com (2603:10b6:610:34::13)
 by CH0PR02MB8026.namprd02.prod.outlook.com (2603:10b6:610:107::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22; Tue, 8 Jun
 2021 13:16:56 +0000
Received: from CH2PR02MB6523.namprd02.prod.outlook.com
 ([fe80::6c51:86c6:fd54:37d6]) by CH2PR02MB6523.namprd02.prod.outlook.com
 ([fe80::6c51:86c6:fd54:37d6%3]) with mapi id 15.20.4219.021; Tue, 8 Jun 2021
 13:16:56 +0000
From:   Radhey Shyam Pandey <radheys@xilinx.com>
To:     Baokun Li <libaokun1@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Michal Simek <michals@xilinx.com>,
        Shravya Kumbham <shravyak@xilinx.com>,
        Matthew Murrian <matthew.murrian@goctsi.com>,
        Romain Perier <romain.perier@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Allen Pais <allen.lkml@gmail.com>
CC:     "weiyongjun1@huawei.com" <weiyongjun1@huawei.com>,
        "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
        "yangjihong1@huawei.com" <yangjihong1@huawei.com>,
        "yukuai3@huawei.com" <yukuai3@huawei.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
Subject: RE: [PATCH -next] dmaengine: xilinx_dma: Use list_move_tail instead
 of list_del/list_add_tail
Thread-Topic: [PATCH -next] dmaengine: xilinx_dma: Use list_move_tail instead
 of list_del/list_add_tail
Thread-Index: AQHXXBJ69U+tzbPdL0iCGBaFy2bVS6sKGIxw
Date:   Tue, 8 Jun 2021 13:16:56 +0000
Message-ID: <CH2PR02MB6523048911423F5583772FE9C7379@CH2PR02MB6523.namprd02.prod.outlook.com>
References: <20210608030905.2818831-1-libaokun1@huawei.com>
In-Reply-To: <20210608030905.2818831-1-libaokun1@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.130]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b587c96e-76e8-40f1-ff67-08d92a7fb0a8
x-ms-traffictypediagnostic: CH0PR02MB8026:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH0PR02MB8026FDEF3C4F290C97A8BB26C7379@CH0PR02MB8026.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:242;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hG6vrAGskBIDoA4wF/SS6cGVr0SVrJ5gDZbz89TSS5g0Ch5OSHpaHOGgonHmBnIbyqx56QdmCLpQL7OqaOaeGXA6Vhjq6TkKDXpMiHSryXodbtADCRV281cyxLNxKBJHCq1ftvGsBxMo4dvXnuXi/SHg2wRhb/6+3oFwyI9WJiEi/YqYFRMAj/3VV+KW4Abz0Lx2f+WTSx/kuxBwYwVdCExXz8Zji02zBJT+DjCNc7t0GgNm6tJkpGPGLwGnMurs8ueQ/lEgrXlIKhFrf0S+wz8gily39urzMhrprSBM1iTPLCcnIz4UrNuOAtd1Il8/CHkA/7AbD/gXYzwVGSWaRUY2RdkWMZmOfi9V26k6BsPYnnIHG0nZFjskLeBbJozvBBaIluMsECIOKcA7PwgsCUy+ozebEfxwwUBq3qECq8b4bqT1yVweRTnizGvHT6GNbDf9xChgFwcF+MS96PXarW9KBX7C258tQHe5FpYjkv9R7v2dT3rwmfa5tPAh+bCAYFGXP299WstQkmZ6JZg5iVY7+gxiHN+RMWWbeMz+FhLkTB27NrVTGzzmMLA8n9PANtIkwfOo7Ts03jJxdh77sYWZivOqKuZo2AOjANGdULSQjgVKpGMUG90aTfLvb/JkzuTH+L1qN5vn6T6vxihDmA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR02MB6523.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(376002)(39850400004)(136003)(396003)(86362001)(55016002)(316002)(110136005)(54906003)(6506007)(64756008)(33656002)(53546011)(52536014)(5660300002)(186003)(7696005)(38100700002)(8676002)(66946007)(9686003)(76116006)(66556008)(66446008)(83380400001)(8936002)(2906002)(71200400001)(478600001)(122000001)(4326008)(921005)(7416002)(26005)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MWEpsn0tvgbK+sf9HQCe0kdR2+ZdxT5EORMGedvwrigfLqYP9d/ESJs/ChIe?=
 =?us-ascii?Q?0Xap3LFbqSSLN2c/mTl2iGmM8M/8OcNKLaT73l6CV92JqAK6yRHvzqFyu3a5?=
 =?us-ascii?Q?NEbyHL5c3fP42iYEVxHFkchGJ8HpFKkIXAm3nZvG+GyDatMrjy5G7CfnHNOT?=
 =?us-ascii?Q?t+7fC1TZLjt9Jroo+vglVdx6izAG1gwjIALe4j35TO6mIIoP8uzHQG3GZ6uR?=
 =?us-ascii?Q?Lhu+Wl2nAbC9LQN4wgftNSwV/lIjkrZC+lvvez+ztE2W+IQZbU/GKGqKTr3q?=
 =?us-ascii?Q?upxbg2eGYvQdBC4k5PHx+gvMMz/tLlEuKZNEDYud/gzN27NAAQ2NCW3sf9KR?=
 =?us-ascii?Q?zpbRcUHepwSz/OFQJhvY7f9V7BaGP5tU8gBQ2uum7XHIIMTdepRWSSQo+Ob0?=
 =?us-ascii?Q?ixpcjk8I//kk1dYX2X3lpwhmyrKtlfMWPEHK3uVqGo2IPsvF360bv0lFWM3r?=
 =?us-ascii?Q?ISwN0Caf2sN3ZPQWNGduxwiBfHmg8ARAFORalD2fJNgyFKnK7C8IktRBteLL?=
 =?us-ascii?Q?BQ0sbUR4zw0SczxYzX4R8tTpCCGwx+zb4w5NKAv3+icx+3/fPF1bfeLc0R5b?=
 =?us-ascii?Q?iY+z7svqwQFDN8qE0VTIAI3fxQHF/fSRN8f6y1/oepEn04kCXGjElrVlzDjB?=
 =?us-ascii?Q?gBX4JSprJPagzNUuxdy7MPTYloeTp7gL8dtYR21JrkHGihgSN57Frx4oEISm?=
 =?us-ascii?Q?D419HONCCHGUIyVeyVTpcEaq+H0fj3OfKbzUrGhnjGW58i4yBv7vGU3SAG7G?=
 =?us-ascii?Q?NOmhCgTOY6t0/zx2m60GU38nquIlYXnr783B1DaveRgNviXqszDdD2Qp7erU?=
 =?us-ascii?Q?Yd6jzH8Zm21Ze1uCAa8hAcr0tMKZmMYmCb9WVNV3FFd/O+NIC/4Nb9o3jEdm?=
 =?us-ascii?Q?s+kgBGah9ZFwobu9iT6L5mKFmiBbPybjkrucMp38lFd3vbAAGynRYia8a7uy?=
 =?us-ascii?Q?2/fuiAReQ8C9iL1jz0i27Mnz7YCaSzEFVkSN39QgJwBcjhIb+HAO01Yx15h7?=
 =?us-ascii?Q?VLQxkQTMn6ZOIL1FhiawH4AGpOXiLoE34W5tbfcObs5FvH9Qd/3tZ7IO4z5c?=
 =?us-ascii?Q?gb/1cMc3U8L4XTzX1cYQO+Dbk2CRFCZuNcCixEyFoE5fzlskCq5dKc4d4DUf?=
 =?us-ascii?Q?Da99WOyxa+vJ/tLPsjgC+nhEcdxG83iL1GiBGyWelqb4SqLlP6YXUTGpgcos?=
 =?us-ascii?Q?P2bwYAIcc6FlW1AoHXz7HrQCTe8gYUAOkNgU8cnFZ9mqHfh3rrj9J2IK5Y3U?=
 =?us-ascii?Q?CC34I2OzXEk26EDVP+TvqZqB0Hr6YMN2YQyJ5wfUanRn9lQU304TX1P5YDxM?=
 =?us-ascii?Q?BJ/7pS0USMqIO6AFBthxDoEF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6523.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b587c96e-76e8-40f1-ff67-08d92a7fb0a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2021 13:16:56.0534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /zOiU82oRgB3o4EmR3wA5EHgNZnKD+zy0dqDlu4wYHu2e1kMbqPwIinZeO3dBTIXswOlopEvN9Ocp9O/rV6dlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8026
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> -----Original Message-----
> From: Baokun Li <libaokun1@huawei.com>
> Sent: Tuesday, June 8, 2021 8:39 AM
> To: linux-kernel@vger.kernel.org; Vinod Koul <vkoul@kernel.org>; Michal
> Simek <michals@xilinx.com>; Radhey Shyam Pandey <radheys@xilinx.com>;
> Shravya Kumbham <shravyak@xilinx.com>; Matthew Murrian
> <matthew.murrian@goctsi.com>; Romain Perier
> <romain.perier@gmail.com>; Lars-Peter Clausen <lars@metafoo.de>;
> Krzysztof Kozlowski <krzk@kernel.org>; Allen Pais <allen.lkml@gmail.com>
> Cc: weiyongjun1@huawei.com; yuehaibing@huawei.com;
> yangjihong1@huawei.com; yukuai3@huawei.com; libaokun1@huawei.com;
> dmaengine@vger.kernel.org; linux-arm-kernel@lists.infradead.org; kernel-
> janitors@vger.kernel.org; Hulk Robot <hulkci@huawei.com>
> Subject: [PATCH -next] dmaengine: xilinx_dma: Use list_move_tail instead =
of
> list_del/list_add_tail
>=20
> Using list_move_tail() instead of list_del() + list_add_tail().
>=20
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Thanks!
> ---
>  drivers/dma/xilinx/xilinx_dma.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_=
dma.c
> index 75c0b8e904e5..77022ef05ac5 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -1411,8 +1411,7 @@ static void xilinx_vdma_start_transfer(struct
> xilinx_dma_chan *chan)
>=20
>  	chan->desc_submitcount++;
>  	chan->desc_pendingcount--;
> -	list_del(&desc->node);
> -	list_add_tail(&desc->node, &chan->active_list);
> +	list_move_tail(&desc->node, &chan->active_list);
>  	if (chan->desc_submitcount =3D=3D chan->num_frms)
>  		chan->desc_submitcount =3D 0;
>=20

