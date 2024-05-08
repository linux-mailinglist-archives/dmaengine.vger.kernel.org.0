Return-Path: <dmaengine+bounces-2007-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05EB38BF488
	for <lists+dmaengine@lfdr.de>; Wed,  8 May 2024 04:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71AF3B21979
	for <lists+dmaengine@lfdr.de>; Wed,  8 May 2024 02:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6E6B646;
	Wed,  8 May 2024 02:27:45 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2120.outbound.protection.partner.outlook.cn [139.219.17.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11202563;
	Wed,  8 May 2024 02:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715135265; cv=fail; b=Wc+n4QtL2t4S1/R6kablDQ6jECzu21M95b+ryX8sWCPrXMRvmBWUCFRcxhkkEn+hjuo2TPXiOIlV7wLZxYgM44MhJWP051ErPwSO4CNeAJzJzth1CtNamX/VvVSKgTSMH5vbDiBRD/Nmfrtac3TKYZ2zGnCDOb5Xj5Zsx1B+rNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715135265; c=relaxed/simple;
	bh=We9o23r+SVJEpuHSsZHi/689nLwLRCIfnwt+O8ufjHs=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A3abEmaChJ7T5hsCyybw+KH/bELZD027sZCklG31g6x5jpu590JgzVO3xNbwOYyM+xupNiZnFz3ACyzYodlncyO/EgYsKKWLFEy8KlMkC2YXZLiOy8UFIS1H4QrSFH9wq2sZcrld74Mj3f8huUNWjhztof2Gse9fA4JH0YfGuGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EQsKAq69qjy6TlUVgBblzSEzGlBtEDdbjHkrSZGOAWpGK+T7I6v/l4eSNBDzY7eh9pfizNv5s9Oi+euiBFknOLrxUw0Xvch5TTjZ+D67MKjUH31j5va5lxFGK3p2b9y2J/Iag5C+HdqvKAxG4OVmfzWmHVP2KuY31ZmB2vja5ZyyHlUH3vmjqOcdheJiHNyU7zD2EOjpwp5tWZV6o8x3d9flXKLe64km1psyTWWnwSzyruCayIIeP6D9H8fUl+ozzRnWD4F5gWamVWK5cpLIFNyfF1zZU9AdCN8Djl4JwGqCpAleZ9Zf0kohfP2IyqEK6gVQXvmn+nwPYEzTS0JujA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QLnQGZ5ippPP0jZe24yEaUHmlcp55nnbfbKxCD9fKN8=;
 b=MEsfpmVNDX+D9OU3bztrWG87FjgsqDdCux+Zc42erQBU+TOayTkIlcCLp4cZE2NLpPad7rAjORMNwNxdljV7d3s58whVDp3XlspPM2CWFKMietb/NEFxQBECpgImAwbiaG0IyR6oX9pFD+YHexnsFL60J7aDfOklIxmfGy2C8E4aL0ABxAs/ZXE6UE5xhwjcOnA+K5Zoz3NF8TFWyXM8aK6P+3CH8bc2tIge4meAcu8YJ9Nji6faAy6WcS1eaA9VaR4hnyECI0eXE+nVw0ZBZSjuPT6nJwUEWmBG1X+hoGyrRDnT9PlHhsctnH2dX9lMiZERHF0Z4EulyL4CRp6cww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:10::10) by NT0PR01MB0990.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:7::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.29; Wed, 8 May
 2024 02:12:56 +0000
Received: from NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn
 ([fe80::3dc9:e0c9:9a09:3bb7]) by
 NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn ([fe80::3dc9:e0c9:9a09:3bb7%4])
 with mapi id 15.20.7472.044; Wed, 8 May 2024 02:12:56 +0000
From: JiaJie Ho <jiajie.ho@starfivetech.com>
To: Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller"
	<davem@davemloft.net>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Vinod Koul
	<vkoul@kernel.org>, "linux-crypto@vger.kernel.org"
	<linux-crypto@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>
Subject: RE: [PATCH v4 5/7] dmaengine: dw-axi-dmac: Support hardware quirks
Thread-Topic: [PATCH v4 5/7] dmaengine: dw-axi-dmac: Support hardware quirks
Thread-Index: AQHabsw166tT/VAf9kyRtlc3qP/LH7GM+pRQ
Date: Wed, 8 May 2024 02:12:56 +0000
Message-ID:
 <NT0PR01MB11829BA51E18082DBD2976998AE52@NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn>
References: <20240305071006.2181158-1-jiajie.ho@starfivetech.com>
 <20240305071006.2181158-6-jiajie.ho@starfivetech.com>
In-Reply-To: <20240305071006.2181158-6-jiajie.ho@starfivetech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NT0PR01MB1182:EE_|NT0PR01MB0990:EE_
x-ms-office365-filtering-correlation-id: 2585e21b-49ce-478e-14cf-08dc6f04605b
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 nc0l1Ak+DlGbumwgrV8r8xe6wak++t9g/411pKkL7DDf0PVjZC/gNc2EiwOeMVeQj6x/hbpPaEkPUjD5nY3IJZOJN7K19Els1ENHsD1sigrefut7loicOyANqWEqUtTff+mz++T8sx19gqZM6ff9+FVlgNgCGGW0avO4R4+mhLCTqrYgCdFiV1ytOFhrQVZm/q74suDWhnGwC34HMrnt6fmzY/5juCJsTVPpSi2ijMLTGZFv9sCHm9qBXLEXfMtq9oWpH0icQiexPSJPytXT/r81Ja9iF52PuiMuPc7uQe8o8kYRj8MYZpk0tHleOmtnUbYfv/DcBzXkwIC0/NORTxqLf/A/hKTnicfU8dwlKQEcmXGnZclGF9TSUdJCxwhUnm+9O980jXfLMgRtww/g6X4jsTtRmDNW/Fwy/vp875MYgPwSi9W5x+VQWT+bl3kKglxfMb6K7oThOPD3kcOvvfdC6XJmL2hBXx9s08cTYXU3p7GY5AXo+HZw358KrNKzMT/ZmuxZJuSs69L1NBxxfFa38RQANK1c6fMiImUIeIbuBOCRrnidB2XysszmYanEuKTDEWHz6CrcWbhl/zMVtmcNKP9VnFXrWjg4X96ivU0TzNBRmimWtNseq/wcLJYI6Bs4oTdWcnjGFwdX6Qh2nQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(366007)(1800799015)(7416005)(921011)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?oDBreAwlnfkQzcj8JiV6mVOBiv55EmBPO3Rhn8vSmj8opazZg1mXTU8+HP+p?=
 =?us-ascii?Q?wgjKFvNsK40uNI7dGqyungxGFwV6xe1tAMd9WyroEujPorO6YXDWeUjf3guH?=
 =?us-ascii?Q?ylltlXMHYRSsKyrlbD/rXC4LJnHzfJWHZoeRlnkakfqw+Lcw671evLfSAM0l?=
 =?us-ascii?Q?ZtqiT5WKuyBCQygTfINFBjktapJVnJNAOCOHe5uyPzxj3mv0AB9/EO5eKBU+?=
 =?us-ascii?Q?4mdx6eWGjNTwiHJeeOElV5K9vYlwojk5BwPd8cPkttWZAcIomQDnloGKbPWh?=
 =?us-ascii?Q?7MwPrn0UqWGSRm6VoQb7OE7OWwEiW6DTjRJYQphKfVZv82rzyxL4a3Nv2vlb?=
 =?us-ascii?Q?YTGvCizaIKQ7hdZmewvTSwSR3jC8vSnW0d2B2QfDdFlA85w9VT6zlqHIM40+?=
 =?us-ascii?Q?Fvu0KGerCllqiXT794mdmmsvCLckkPaF0VbPu98qfhVGoW14V345PzAbd2so?=
 =?us-ascii?Q?LHvH2Ckfwm06dXOnDyCsPQmn4G/btOEA40qRB6AEYxP2kZVnyMW3kbIuGDRq?=
 =?us-ascii?Q?UvfYFkgMoF8YLIUDRZPMccmsvkOZfsvUKFmBWe5vz32PwG/zMqQcin+huGy1?=
 =?us-ascii?Q?hCzThLuZBSaLMQDHnXb4JiSjfdqIz88/4q9lLwNOKPAHYUTTGYe/erzeb4qy?=
 =?us-ascii?Q?faETfFMuhSGRIz28Oz7wA7nhy/GWcaTUNJ/0zhekrSWVhtR5pFNPuDaxBGME?=
 =?us-ascii?Q?BrJCypCy+QqXvcvJpW2Tg3cmwB+k+aM9nByrdUEVZysti9a8xmUyPryfnF3W?=
 =?us-ascii?Q?qsrNQu3L4tk93YZt83Oa9HO6qML9IQ07O3jXVr33Elr0F5XVWfK6zxEXvSJ1?=
 =?us-ascii?Q?wgHG/pOnJsz/wCJvNxeBUODSjfyNDw8D7YLqYu0kDtsDnriU7Bdpzovnr6Kq?=
 =?us-ascii?Q?g+9w2WxmlekSqqaigBN0qbR+M0a6ccbAL1glEqBSzN1hCnf4C2njek4Rm3mu?=
 =?us-ascii?Q?3KYpWF6uA65McOnZXLlypkP365iDpMALR1R1xIrb8yPqoDGIE/AJfyE+F3T1?=
 =?us-ascii?Q?lcV6TYNHdP6bnAjXWZlzQ+uCOgYrXPYLpdBKkeBE60/Am5e4ZKjRud73mqOm?=
 =?us-ascii?Q?QUceAh8IYZ42FrHgnS3OjB73ZRTEl4bUh7M7+0YqFnSS4p5vU4Wl3FCGiXks?=
 =?us-ascii?Q?qCOmGrJmz5vVOISEFbJqutSiY2HUflLSzB9ZYmFZNwEnBudidyg7uN0AvJYe?=
 =?us-ascii?Q?YsaWRlUBkSSbzEpao1ADn/mm8QFBBTWC5Hatixqn1dJohNM5hW6336CTGZw1?=
 =?us-ascii?Q?C5JujU611HvXlFPdBU7OqPWaqiSjdJw4yhqBlBnM2hokKErNEBFAElRSgd/O?=
 =?us-ascii?Q?PLjo4qywtiJYuEHwc9ZYhthAm6JPQ/Q5qhe3TJ/N6pZtaw5VqkYPz5sIodgT?=
 =?us-ascii?Q?8cFVeZKMGHXq3YITKCJN61drCDioj7ff/uO3DlTfZjbkBxVRL0RmxyrYQ7NZ?=
 =?us-ascii?Q?i49+6H2HDpDhdDvF/Jd+2jtsMU1b58XwKHAuPppOkOdQ/TCeNdqBeryiJc56?=
 =?us-ascii?Q?TcecUPPY2ZheG/rm1NkLx321U8/qre2Sqf51UKy5KWP1huBLJzecFJ7c8I46?=
 =?us-ascii?Q?nlSgiQW2C1jMJdfHgLtU02L+Abe85BcxB688Py2H?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 2585e21b-49ce-478e-14cf-08dc6f04605b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2024 02:12:56.6672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Y9n/OoCnrz0LypLfMxXxb9f0eKqq6T3xQZksMGUftnRF5DPlnsQsq8eaI+nVqfevKK4tXlmnBD1bpnFMYG6A9Ig46zR8SaIDuMxdYN/3h0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB0990

> Adds separate dma hardware descriptor setup for JH8100 hardware quirks.
> JH8100 engine uses AXI1 master for data transfer but current dma driver i=
s
> hardcoded to use AXI0 only. The FIFO offset needs to be incremented due t=
o
> hardware limitations.
>=20
> Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
> ---
>  .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 32 ++++++++++++++++---
>  drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  2 ++
>  include/linux/dma/dw_axi.h                    | 11 +++++++
>  3 files changed, 40 insertions(+), 5 deletions(-)  create mode 100644
> include/linux/dma/dw_axi.h
>=20
> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> index a86a81ff0caa..684cabe33c7d 100644
> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> @@ -647,6 +647,7 @@ static void set_desc_dest_master(struct
> axi_dma_hw_desc *hw_desc,
>=20
>  static int dw_axi_dma_set_hw_desc(struct axi_dma_chan *chan,
>  				  struct axi_dma_hw_desc *hw_desc,
> +				  struct axi_dma_desc *desc,
>  				  dma_addr_t mem_addr, size_t len)
>  {
>  	unsigned int data_width =3D BIT(chan->chip->dw->hdata-
> >m_data_width);
> @@ -655,6 +656,8 @@ static int dw_axi_dma_set_hw_desc(struct
> axi_dma_chan *chan,
>  	dma_addr_t device_addr;
>  	size_t axi_block_ts;
>  	size_t block_ts;
> +	bool hw_quirks =3D chan->quirks & DWAXIDMAC_STARFIVE_SM_ALGO;
> +	u32 val;
>  	u32 ctllo, ctlhi;
>  	u32 burst_len;
>=20
> @@ -675,7 +678,8 @@ static int dw_axi_dma_set_hw_desc(struct
> axi_dma_chan *chan,
>  		device_addr =3D chan->config.dst_addr;
>  		ctllo =3D reg_width << CH_CTL_L_DST_WIDTH_POS |
>  			mem_width << CH_CTL_L_SRC_WIDTH_POS |
> -			DWAXIDMAC_CH_CTL_L_NOINC <<
> CH_CTL_L_DST_INC_POS |
> +			(hw_quirks ? DWAXIDMAC_CH_CTL_L_INC <<
> CH_CTL_L_DST_INC_POS :
> +				     DWAXIDMAC_CH_CTL_L_NOINC <<
> CH_CTL_L_DST_INC_POS) |
>  			DWAXIDMAC_CH_CTL_L_INC <<
> CH_CTL_L_SRC_INC_POS;
>  		block_ts =3D len >> mem_width;
>  		break;
> @@ -685,7 +689,8 @@ static int dw_axi_dma_set_hw_desc(struct
> axi_dma_chan *chan,
>  		ctllo =3D reg_width << CH_CTL_L_SRC_WIDTH_POS |
>  			mem_width << CH_CTL_L_DST_WIDTH_POS |
>  			DWAXIDMAC_CH_CTL_L_INC <<
> CH_CTL_L_DST_INC_POS |
> -			DWAXIDMAC_CH_CTL_L_NOINC <<
> CH_CTL_L_SRC_INC_POS;
> +			(hw_quirks ? DWAXIDMAC_CH_CTL_L_INC <<
> CH_CTL_L_SRC_INC_POS :
> +				     DWAXIDMAC_CH_CTL_L_NOINC <<
> CH_CTL_L_SRC_INC_POS);
>  		block_ts =3D len >> reg_width;
>  		break;
>  	default:
> @@ -726,6 +731,17 @@ static int dw_axi_dma_set_hw_desc(struct
> axi_dma_chan *chan,
>=20
>  	set_desc_src_master(hw_desc);
>=20
> +	if (hw_quirks) {
> +		if (chan->direction =3D=3D DMA_MEM_TO_DEV) {
> +			set_desc_dest_master(hw_desc, desc);
> +		} else {
> +			/* Select AXI1 for src master */
> +			val =3D le32_to_cpu(hw_desc->lli->ctl_lo);
> +			val |=3D CH_CTL_L_SRC_MAST;
> +			hw_desc->lli->ctl_lo =3D cpu_to_le32(val);
> +		}
> +	}
> +
>  	hw_desc->len =3D len;
>  	return 0;
>  }
> @@ -802,8 +818,8 @@ dw_axi_dma_chan_prep_cyclic(struct dma_chan
> *dchan, dma_addr_t dma_addr,
>  	for (i =3D 0; i < total_segments; i++) {
>  		hw_desc =3D &desc->hw_desc[i];
>=20
> -		status =3D dw_axi_dma_set_hw_desc(chan, hw_desc, src_addr,
> -						segment_len);
> +		status =3D dw_axi_dma_set_hw_desc(chan, hw_desc, NULL,
> +						src_addr, segment_len);
>  		if (status < 0)
>  			goto err_desc_get;
>=20
> @@ -885,7 +901,8 @@ dw_axi_dma_chan_prep_slave_sg(struct dma_chan
> *dchan, struct scatterlist *sgl,
>=20
>  		do {
>  			hw_desc =3D &desc->hw_desc[loop++];
> -			status =3D dw_axi_dma_set_hw_desc(chan, hw_desc,
> mem, segment_len);
> +			status =3D dw_axi_dma_set_hw_desc(chan, hw_desc,
> desc,
> +							mem, segment_len);
>  			if (status < 0)
>  				goto err_desc_get;
>=20
> @@ -1023,8 +1040,13 @@ static int dw_axi_dma_chan_slave_config(struct
> dma_chan *dchan,
>  					struct dma_slave_config *config)
>  {
>  	struct axi_dma_chan *chan =3D dchan_to_axi_dma_chan(dchan);
> +	struct dw_axi_peripheral_config *periph =3D config->peripheral_config;
>=20
>  	memcpy(&chan->config, config, sizeof(*config));
> +	if (config->peripheral_size =3D=3D sizeof(*periph))
> +		chan->quirks =3D periph->quirks;
> +	else
> +		chan->quirks =3D 0;
>=20
>  	return 0;
>  }
> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-
> dmac/dw-axi-dmac.h
> index 454904d99654..043d7eb7cb67 100644
> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
> @@ -14,6 +14,7 @@
>  #include <linux/clk.h>
>  #include <linux/device.h>
>  #include <linux/dmaengine.h>
> +#include <linux/dma/dw_axi.h>
>  #include <linux/types.h>
>=20
>  #include "../virt-dma.h"
> @@ -50,6 +51,7 @@ struct axi_dma_chan {
>  	struct dma_slave_config		config;
>  	enum dma_transfer_direction	direction;
>  	bool				cyclic;
> +	u32				quirks;
>  	/* these other elements are all protected by vc.lock */
>  	bool				is_paused;
>  };
> diff --git a/include/linux/dma/dw_axi.h b/include/linux/dma/dw_axi.h new
> file mode 100644 index 000000000000..fd49152869a4
> --- /dev/null
> +++ b/include/linux/dma/dw_axi.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __LINUX_DMA_DW_AXI_H
> +#define __LINUX_DMA_DW_AXI_H
> +
> +#include <linux/types.h>
> +
> +struct dw_axi_peripheral_config {
> +#define DWAXIDMAC_STARFIVE_SM_ALGO	BIT(0)
> +	u32 quirks;
> +};
> +#endif /* __LINUX_DMA_DW_AXI_H */
> --
> 2.34.1

Hi Eugeniy/Vinod,
Could you please help review this patch?

Thanks,
Jia Jie

