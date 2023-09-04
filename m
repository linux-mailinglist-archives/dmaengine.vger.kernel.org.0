Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E0D79157E
	for <lists+dmaengine@lfdr.de>; Mon,  4 Sep 2023 12:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235414AbjIDKJC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 4 Sep 2023 06:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbjIDKJB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 4 Sep 2023 06:09:01 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2073.outbound.protection.outlook.com [40.107.21.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2B8E1;
        Mon,  4 Sep 2023 03:08:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UUCyhG6+o8wnDr4UZkU7WTrv6HzJctmAI6oCrlODDHiqheM0aBb9eNotbVD3Svr0L4vGz31flbTwpLAdC/UhEYWRnoB/Ah+ZoQvk5ipnsqBNnBqpGaFOlG43/b++LzCqmOpwteaG2XMeMo+ugy48UC3a6L6WIBN6u4ilFjWBMcVW2tqHbAkQwPpCfSRQWG98GC6Agrbqf4naNa5YyBI7t/I+EgirkoHFbPI51gNppgKLgDf+vKcG9BVHawY8ppbl8MiWl8TJAm6UeaCvVaQdqnpzSaGhXwFWc5vN8C9jw3HIdD8WNS9eYdD1mrmnGG19GuJXUwKhtqZAxAxBA4ywjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dBCW/yztI+3kRfvaMkCgHxEnY2grAfS/KIXihJ5URDc=;
 b=oX3+UU/ra4YExTmn39DYTe9jtVPRR9H1U3HMlq03xNwdHTXDElIOoqlDt3s12RGCOU6zm6MAvVRs+iwzhQ51u9+iZ9u/86yr3SbpnbzrAADEe8dGsNy7zQvpCNhn6Wwycb4K56fA1pCnN080F/fsjJxFoofo6PsCqak8T3/XSPyeFQLNWf7D94QNdkeFqjfB2Yo6pTRqf0nutzvFbVYZ4CbTeRQSrFumY2lrb3yHeF2MYuevKTDnA/T/+eJVZmlCc+/sv5UEeOuAkARf4w92kRppsBj+3VOh6H/wfJAYS7gcVK1MiQzHXJvJzKgxOypZRvjqH9vFt0MSySAXYUePjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zigngroup.com; dmarc=pass action=none
 header.from=zigngroup.com; dkim=pass header.d=zigngroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zigngroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBCW/yztI+3kRfvaMkCgHxEnY2grAfS/KIXihJ5URDc=;
 b=KqjxQEpjQZ+BEjp9gxqYT8Q/KEmt4CcHXq6gr5TJH/YuRHGi1wFBbW5tXUjob0OpJ1KqPYJYRMOIIgrCk4dDywfut9+NZnKYwdto89p/cFkSAIF+/yyYqPist1ZxGHkin5dWADbfaZMz0nQjJyo71JD0q3we0n3f6CRY7J60N78KcLcQcve+MePyPydsaLYVSTio8hRBj3FDyp3aHjfh1Ns3NbVCzHhFTqDbArx4jjSlFoGpZN7IKplBG5SsxSP0q3leIGexGqPmVB680qSoeEUd/Ip6BRgK1FU4qwtV9+RZAMOG14tHHd/up/cadqE0HrhOvK1YVg9c/1zxL2PzmA==
Received: from AM0PR08MB3089.eurprd08.prod.outlook.com (2603:10a6:208:57::16)
 by PAWPR08MB10091.eurprd08.prod.outlook.com (2603:10a6:102:366::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32; Mon, 4 Sep
 2023 10:08:53 +0000
Received: from AM0PR08MB3089.eurprd08.prod.outlook.com
 ([fe80::9996:b031:1326:a132]) by AM0PR08MB3089.eurprd08.prod.outlook.com
 ([fe80::9996:b031:1326:a132%5]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 10:08:53 +0000
From:   Tim van der Staaij | Zign <Tim.vanderstaaij@zigngroup.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Vinod Koul <vkoul@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: deadlock when imx-sdma logs "restart cyclic channel"
Thread-Topic: PROBLEM: deadlock when imx-sdma logs "restart cyclic channel"
Thread-Index: AQHZr+fVlI/NmSx7t0uXzxV1fonxNK+5Yu0AgFFhdDE=
Date:   Mon, 4 Sep 2023 10:08:53 +0000
Message-ID: <AM0PR08MB3089D5A1D1F017E700CC3DB580E9A@AM0PR08MB3089.eurprd08.prod.outlook.com>
References: <AM0PR08MB308979EC3A8A53AE6E2D3408802CA@AM0PR08MB3089.eurprd08.prod.outlook.com>
 <CAOMZO5A4NbZAxB5MSkQqXW+wknXAz_xViTSmyfBakJjz9Ja1Gw@mail.gmail.com>
In-Reply-To: <CAOMZO5A4NbZAxB5MSkQqXW+wknXAz_xViTSmyfBakJjz9Ja1Gw@mail.gmail.com>
Accept-Language: nl-NL, en-US
Content-Language: nl-NL
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-codetwoprocessed: true
x-codetwo-clientsignature-inserted: true
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zigngroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR08MB3089:EE_|PAWPR08MB10091:EE_
x-ms-office365-filtering-correlation-id: e1c2c350-284f-40f3-35a7-08dbad2ef174
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aW7ctLKoQ5sqwK+J9pPfFZjkb+UrAbfBwpAigEATTsUFfeYUhzrcM8L+DyGjXA+6u66XSI85U5tu27AKmPPC6krJ6B0YutX9HK2igeKU3Bz9plBkWkcfQoZs+qfIxB25m5umBsJZ2pZk3zy67+B4hmmZ4Zi1SFrYN42DArtfrjHXD3ma1dZKB3JZBzTvvCyYpnyrH0WYGF/y2qTGAR+Lnb8L/b+pB84WHenOb6qiLSdwgV1TGDEK8HOvX4Owbi8lR7I+xlf/aeBADxREbGsBSRlpvcDcfA7FbZFIq/fQI2Ig3KUxVwsLKQHc4EZWdHO9FsE9xO3IR+FQ6GkEbdQg5ubep+ETJRFWqAdsv9UEGT+cy9Jh0FN3I4T1KW9vUkRgOm4XbgpjTquF54JicemQofLKa1EEQy2Kyw5BqfVd36l6Ec2FsI5Qq7WIKHcO1M7+NTwWy01aiioDv8yR3s3lSOcYv1wtHPE6TzHQI/3ZOQuceI4E08v28zOlW15wRAvpLtLP+IHhAd5Qq1L7g4SgVP3Hym1gRYKnOZMYcPd4Az/GrCa9E9ZE9bL2RZTO9GzwZgXL1gNN9yDaUbhupzJb1BgcJCsn5ykL9oQW0Q+vrQd45KKOEN6fx1Ah1Dp4gI4S
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB3089.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(39830400003)(136003)(186009)(1800799009)(451199024)(41300700001)(71200400001)(7696005)(6506007)(122000001)(478600001)(83380400001)(9686003)(38070700005)(38100700002)(55016003)(54906003)(76116006)(66946007)(2906002)(66556008)(66476007)(64756008)(66446008)(6916009)(316002)(33656002)(86362001)(5660300002)(52536014)(8936002)(4326008)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?g32joB+qosJf9VJB/yt1acBUUZbJwozPvzi4vLRv3KX665wJAlAbycQ+EZ?=
 =?iso-8859-1?Q?j2dnY3CEWCzdXOhXwB3zlAmqKSr1/62+/mxgEQzdamSt0P+wTe6o67PwQ9?=
 =?iso-8859-1?Q?v1UOobYddqH98rYwtpJoWk3X5UbYXFhe9M0QawnMAjiyDD9s+nJw5pVttP?=
 =?iso-8859-1?Q?rZT9dzTYlY+ZW4TDMje+1O6HRlFyii+3+MKzHDwi7qadKzlKZhLGgaf/qA?=
 =?iso-8859-1?Q?lmxB0EQdHzGktmLec5qwPEzE4G9XMPx6chLuSHNvm7UnOCz4mjgqUchCmq?=
 =?iso-8859-1?Q?k0E0XXr2doQgMkS4xR1MmKzofEP8ADN5MEFF1mNzr74KMxJrcPFm7yxi20?=
 =?iso-8859-1?Q?foj/ar5joV/NRP4UZM5UvVjs+BJaDL+yFqhrfBvqQPvwvBb03kCBa6Cmv1?=
 =?iso-8859-1?Q?Ldny1Nm+Rjr8YLQuQ5abuT8zW8u+NxdoSJKwy7bqGW3WhxhCrZ/77hQVVQ?=
 =?iso-8859-1?Q?b9USqgMcIoWRp1hti9NDzLagWqJV7g4NfMmKnvib6InpcnQvcyF5/fk0on?=
 =?iso-8859-1?Q?qnopDunET9eS93Y5xId+RjZFCJUBDfAESVxy/0vl88DoT7zlBfuKgB8hEk?=
 =?iso-8859-1?Q?N/v3WuiumIaWg1bUo7C/7h+2L80D7I4rKBl4sfTI55U8D8DQQvQGEa3wZC?=
 =?iso-8859-1?Q?mjbVVhzCFjeI3YEJNQK0b0tnCT15w+QqKGvepWKyOLTRcO5TYn+9n3Vd+j?=
 =?iso-8859-1?Q?X+r9c0dGe1rGMQPE3q2qGAYtIH3/GZ5j3afd7g7haiS5gQ4VIetpFIBQVM?=
 =?iso-8859-1?Q?6cmZUVLyveI4Q4r9/2gb9Z8cyuc7bqRoU6db4vglDJV5UYZeY5ijBvtNnd?=
 =?iso-8859-1?Q?xLCdfQ962V8hktn8gN02wxd0pn/D2QP0tWI8/LZ0ha8R44BJSCa0Uay7Ih?=
 =?iso-8859-1?Q?baioIIow10GVDg1y7o5ehdbhRnCYIzLLlt0Qc39Q0JLfE+pepMJ/qXErzN?=
 =?iso-8859-1?Q?6LH5E5GCOxPXtKYA6mHs7W7gy3B/nQ2eRorVunG3PKp9GPtZofDcZjD5Mi?=
 =?iso-8859-1?Q?wzn9VJ0eJ0cszR+hGWWQkeJYOsGI/mnN21wkbeSQ5sZCfdm9KH2u7Cpjcc?=
 =?iso-8859-1?Q?G6ArkZwfzHbR1DvUxOb0YdVsjzNa6peQA8QMvNoFhoRuVzH+TojEw1E3yU?=
 =?iso-8859-1?Q?D8ZULePO7AmfXKhy+zXdvSAPk1NAEK5CFWpim1dUCMU0ePDi1r41JtWrtl?=
 =?iso-8859-1?Q?1YEi3lyzK4XDgPzCeQw/G/Qtgd1K+G3RrrE/SLX7EVYuAuXthkAD457iu4?=
 =?iso-8859-1?Q?iwACAXfGEhSt1ROLBFfk6d2DqTE1GpJ0mOks0PwOT+GS65RrgCobhVyZMt?=
 =?iso-8859-1?Q?UCYE0yLEbbOZRW0t9D8FTYgXpemSHAEDo3PRxo4fl+sfUEFLAd2UihBQ1D?=
 =?iso-8859-1?Q?TMCU3wlos/xjUj5hh0O57xeCXD6a+rwx53NbnCmZwIlwLrRaOdoP1hkWMc?=
 =?iso-8859-1?Q?2RpMeWPrsqYmGbbxmfkMT+hAp0Ek+b4+SN2edbIgJFCDVCW08knbycvbBv?=
 =?iso-8859-1?Q?onnM0QrqynHses1WWn/VLUTqMlvqc9iawsF2AdC8t3GR95+Wp9amXH0E2I?=
 =?iso-8859-1?Q?lE3TpUHP/A3Ry8Inb09djOgjyFMFOeiMF7JXemUUighqKE5Lt31GToaOTB?=
 =?iso-8859-1?Q?8zh71HRYAfwZxtRkxM5Oc7eNlI+FdwURHqIQk2oFrarZa4RBuYUwf03q7G?=
 =?iso-8859-1?Q?CVMRpuifapew64OT+xJXSOVtbjea+lNoVemgD+CuTDmKbBLFa3qpmtLYnz?=
 =?iso-8859-1?Q?f9Zg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: zigngroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR08MB3089.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1c2c350-284f-40f3-35a7-08dbad2ef174
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2023 10:08:53.4027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ec7f600c-e944-4b82-8191-695b8f02591d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ILlWy7jVYBLurw7gFXErB3lS6tMEzs8nysxrvvc8cxvnAi9qeae2ipJuV6NPAxj2K/tLfTiQm/niGdgEBXLwWapXXtl12AbekSGvstn7y1g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10091
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_PERMERROR
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Fabio,=0A=
=0A=
Fabio Estevam <festevam@gmail.com> wrote:=0A=
>5.19 is not a supported kernel version. Please test it with the latest 6.5=
-rc1.=0A=
=0A=
Apologies, I was supposed to be using the 5.15 LTS kernel but due to a misc=
onfiguration it got mixed up with a 5.19 image.=0A=
=0A=
Unfortunately the circumstances for this bug are difficult to reproduce and=
 I cannot do so at the moment.=0A=
=0A=
Please disregard the bug report for now, and let me restate the issue as a =
theoretical question about the locking behavior of the driver.=0A=
=0A=
Consider the following functions in drivers/dma/imx-sdma.c in the latest ma=
ster revision:=0A=
=0A=
static irqreturn_t sdma_int_handler(int irq, void *dev_id)=0A=
{=0A=
	struct sdma_engine *sdma =3D dev_id;=0A=
	unsigned long stat;=0A=
=0A=
	stat =3D readl_relaxed(sdma->regs + SDMA_H_INTR);=0A=
	writel_relaxed(stat, sdma->regs + SDMA_H_INTR);=0A=
	/* channel 0 is special and not handled here, see run_channel0() */=0A=
	stat &=3D ~1;=0A=
=0A=
	while (stat) {=0A=
		int channel =3D fls(stat) - 1;=0A=
		struct sdma_channel *sdmac =3D &sdma->channel[channel];=0A=
		struct sdma_desc *desc;=0A=
=0A=
		spin_lock(&sdmac->vc.lock);=0A=
		desc =3D sdmac->desc;=0A=
		if (desc) {=0A=
			if (sdmac->flags & IMX_DMA_SG_LOOP) {=0A=
				if (sdmac->peripheral_type !=3D IMX_DMATYPE_HDMI)=0A=
					sdma_update_channel_loop(sdmac);=0A=
				else=0A=
					vchan_cyclic_callback(&desc->vd);=0A=
			} else {=0A=
				mxc_sdma_handle_channel_normal(sdmac);=0A=
				vchan_cookie_complete(&desc->vd);=0A=
				sdma_start_desc(sdmac);=0A=
			}=0A=
		}=0A=
=0A=
		spin_unlock(&sdmac->vc.lock);=0A=
		__clear_bit(channel, &stat);=0A=
	}=0A=
=0A=
	return IRQ_HANDLED;=0A=
}=0A=
=0A=
static void sdma_update_channel_loop(struct sdma_channel *sdmac)=0A=
{=0A=
	struct sdma_buffer_descriptor *bd;=0A=
	int error =3D 0;=0A=
	enum dma_status	old_status =3D sdmac->status;=0A=
=0A=
	/* redacted for conciseness */=0A=
=0A=
	/*=0A=
	 * SDMA stops cyclic channel when DMA request triggers a channel and no SD=
MA=0A=
	 * owned buffer is available (i.e. BD_DONE was set too late).=0A=
	 */=0A=
	if (sdmac->desc && !is_sdma_channel_enabled(sdmac->sdma, sdmac->channel)) =
{=0A=
		dev_warn(sdmac->sdma->dev, "restart cyclic channel %d\n", sdmac->channel)=
;=0A=
		sdma_enable_channel(sdmac->sdma, sdmac->channel);=0A=
	}=0A=
}=0A=
=0A=
As I understand it, sdma_update_channel_loop potentially calls dev_warn whi=
le sdmac->vc.lock is still held by sdma_int_handler. Then, dev_warn will al=
so try to claim this lock somewhere down the call stack to safely access th=
e device details. Is this a recipe for deadlock as I suspect, or am I overl=
ooking something?=0A=
=0A=
Kind regards,=0A=
Tim=
