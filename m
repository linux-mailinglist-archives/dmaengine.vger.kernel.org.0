Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B195E7AA12F
	for <lists+dmaengine@lfdr.de>; Thu, 21 Sep 2023 22:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbjIUU6h (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Sep 2023 16:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbjIUU6F (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 Sep 2023 16:58:05 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2071.outbound.protection.outlook.com [40.107.105.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F3E4F90D;
        Thu, 21 Sep 2023 10:15:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jb8tNmQ2DMN3Kba82A3+kSrY8Unm2ImMmDViad9jUTRHIlvA48anhr84GJaJlP6zGfA3YvLtoXsNw5Xc91roTbX+Vd6KM4bCmk2spGHxfRDTbwq8C4gDiULKG44aCntubKXQtk10A6C6pObiz8jMYgIyq/jGc8519xEX3BkdrANGd9ky14xJ96vVJeb1Fc07T2TRWg8jpDj8Y0S42WsYkVcu9ZMncwUcVkPKmZpejJi3mFXPjj888wZ9Bn4SJUkFuuSafz2kuNDijzK01R9Hb4yhMNE6pPm1/RYb88SzYwlsxWOD5WqRd+2q8oTlqlDH3X3nJ2eWuN0Kmz4g8BnUoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0cc+HwtG5wF2zEMFtmvIcBJOkIYkC+Xf3+D4KeQ/ZwA=;
 b=R3jzaxVe+xOqb9pVMw+7rql7kHyEZxQ6SV54RFA8NOLCLx4rHyqHEsDSvc69svrKgQxGO+5B12cuc4IEyyGkjqHeoXzkn4zzn/KWjfzU17//cVxeJ6s6ayCH49gavfnQ5Ty+O2pDQahuagdFRaPs2SGFd9VU6a1HEbHInFqKdIsGm4frk7LZxQBLnfi3nD3q0F4SiNnAL/IFZVEnh3MdfV0qIX1eTPYOTpy7lxI/K1/+lAonIG5HNv+NJMlL1GgTYLQHBmy+cDWo7sBgTAEU+82y9Kz+MKJux1edXtoiZMwKo9hXY9Cxnm6JoikN5YHZDKx6ifaf7VBcpyKa+kfgRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zigngroup.com; dmarc=pass action=none
 header.from=zigngroup.com; dkim=pass header.d=zigngroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zigngroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0cc+HwtG5wF2zEMFtmvIcBJOkIYkC+Xf3+D4KeQ/ZwA=;
 b=B0YFLAujhOIbvPzGu47nf3tnbY84i98171cDwWYHlKAla9O0ienKnWQy1LuI+6iLcV9EfUdl7Rq081kKbBuaui9FdkQDqTQAbm5vsrzzzSjEe46VxIRbbXinvzRFh48mPB3ZobGkEU1aRxNfJ6YEcKq43XscXRWTJ+o4r8bCrCN65J90IIfKj3PMY+2Bof86lbNKdJCr9U28kMhcH/13O2pHCKX6izfwN3iRb47axJvOjDuWD011g5DHHWrQZV1jkaPxX/bnq5uC9+4RE6/io99gbaMmcwDZhNvnsefGbTr945q85LBWuvHIrP0iSzP5bYBRtJ4UjgAT+rJtFyB+Rg==
Received: from AM0PR08MB3089.eurprd08.prod.outlook.com (2603:10a6:208:57::16)
 by VE1PR08MB5631.eurprd08.prod.outlook.com (2603:10a6:800:1ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Thu, 21 Sep
 2023 09:57:11 +0000
Received: from AM0PR08MB3089.eurprd08.prod.outlook.com
 ([fe80::e955:6f4c:9b5b:2d33]) by AM0PR08MB3089.eurprd08.prod.outlook.com
 ([fe80::e955:6f4c:9b5b:2d33%7]) with mapi id 15.20.6813.017; Thu, 21 Sep 2023
 09:57:11 +0000
From:   Tim van der Staaij | Zign <Tim.vanderstaaij@zigngroup.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
CC:     Vinod Koul <vkoul@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] dmaengine: imx-sdma: fix deadlock in interrupt handler
Thread-Topic: [PATCH] dmaengine: imx-sdma: fix deadlock in interrupt handler
Thread-Index: AQHZ7HFXCtmZOIdMP0ek3TzK7ZAfKw==
Date:   Thu, 21 Sep 2023 09:57:11 +0000
Message-ID: <AM0PR08MB30897429213E8DB9BCC1D6C880F8A@AM0PR08MB3089.eurprd08.prod.outlook.com>
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
x-ms-traffictypediagnostic: AM0PR08MB3089:EE_|VE1PR08MB5631:EE_
x-ms-office365-filtering-correlation-id: 51d5dfba-9ffe-4bea-2c92-08dbba89200c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YeE4EGBkcb+rJJ5O6ZyfCtxXWT4rkSiLp1EAwfhg7DBzvmzGXA068CIojuZAVdb7QkV/gE0x7PcTyGbnvfHsetYZN3nyT2DZdXu/C1Pxe/mZ2F84IDlPdozl3w/6DnyMBhKvO4l6b9akZQyq51waBdrJWRg+MHK0GPTDHllcOrNNWnf0DHU0YhJepKEhI05ERWvbGBS6I4jE1AYioG+tZyrctNICbFLq14amDFC2M+ApYaZ/vcT8fgSDwJHIXwQ5Fficr41fHGdCYOE/4lu2Ubhdb3nj28zbXv8cjzYjnGVTapqa0i/TU7TgJCuN/XZLMFOq23NDsoTHjtivaWdFbQnXbnEC962QNbVVQxMaHHmYavpWgEEImRVZ5yv5D1a8WpsWssSRnEDS5zaseq0moOsNwUIMAcmhqEvEXUVBz7yKuYdHQQvr5598Dvt3Bgebjjc9XuXBwWwNUjkWNe6UshiOMU0unLh+ZSfF3WDj6D9jFt8+D1X8t+zjbGZUiwNsAzO64J0cmFCgJRC+fEULH0eN0emqP+RCdsMhJzrEV6+U4Wx8MePWiIPzt6326VUrXRVy83MdsPyPEEBEEvlbFboiphyXUxSlVBXd9NAs9OA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB3089.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39830400003)(396003)(136003)(366004)(42606007)(346002)(451199024)(186009)(1800799009)(8936002)(4326008)(8676002)(26005)(55016003)(5660300002)(52536014)(316002)(9686003)(41300700001)(38100700002)(122000001)(38070700005)(86362001)(2906002)(83380400001)(33656002)(71200400001)(45080400002)(478600001)(7696005)(966005)(54906003)(6506007)(66946007)(66446008)(66476007)(64756008)(66556008)(76116006)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?vLXB0GVI+DhHhM9NphpvVUMK6fUDCmq5rLKyCrbDmCMAr/eUmRLSaeqtqc?=
 =?iso-8859-1?Q?yRu6dBr6nrKNYCC6fNZiyP3ak7IcKN9e2etvVzku1snLK0RmYXG3CD5V7Q?=
 =?iso-8859-1?Q?+9l46JCXd2J9xZToXjra97fVJjbZpY2jihdbl4wBdAbdU+ccr2fN8OcQD1?=
 =?iso-8859-1?Q?YwTqQm+QpAlKhBDlTrdI+1qJTbwu5HJnsYMwL8czgzoAFhEFEZjWaPYAIp?=
 =?iso-8859-1?Q?3BVhAty8Nw8ZE7Bme1M72gEh4e9cE7mkKmsfjFeV8e3J9hLfzd9dEdQPyM?=
 =?iso-8859-1?Q?1t2lssjBQUlXAVrC/76tr5R26IU257YKzs6Ody3bX+ZPLBU5tSsgnR7s/7?=
 =?iso-8859-1?Q?vutdf5xbTHGK7e7ztjxnKtiIG1tPiXRIOq4fzpJA4Oqlt4UB9D2DEmP5zF?=
 =?iso-8859-1?Q?WYWsJMpvY7bhyMwB8b6v1SNMIZ84BKBC/MBTFEKj4j/pzNkbJ0BrERXBMN?=
 =?iso-8859-1?Q?SKjIkltAJMQdO0CkuykNfRxdS8pf1W6B/NtMrPo94d8AYTd8Dpke2y/Mvq?=
 =?iso-8859-1?Q?d1F1YdugN78eMS6M20jH8cMgot/fBtnJtgSTV32Y1E1ix/3vaZXbe7qcJO?=
 =?iso-8859-1?Q?psW64gE3ZU9PCtP8+HsFjiC3smQWSrHEy5EVeGbzUjR8b6Zf0H1UxnYqY/?=
 =?iso-8859-1?Q?iMwGmqCzDcccWUUJK1y6xhKKhoN1q0KiebZqx62QEKC3BgrX1zMKYr2+sj?=
 =?iso-8859-1?Q?iy7nUBqaFGdKS+HeiNDNds4P4JWak9QEcdAJ2JISdwm8scLeWocV5T7yiK?=
 =?iso-8859-1?Q?OHoR1hwS/8MHhohEj52jsGAOVtcfENw9ApwiMJDb510sFYQeqemujvi4/Y?=
 =?iso-8859-1?Q?97fo3MCsSmmNezjRJMz+mkG4RN18BFbT27PXXM3XQyXUUyWonwdJECuEM+?=
 =?iso-8859-1?Q?GNqaPPalQHcndyIBqPZSoBw+mbDwMj+i8HumQDGwvdBKLnQ08xuPyr/ySF?=
 =?iso-8859-1?Q?nZv45dFA2PBzLAW1dQEvEj+Y0WN2TOHlr4IgYbQWoYDzpANkTbgiDzV+oQ?=
 =?iso-8859-1?Q?nIXiOVJlPKTmmNFm3h0vxhj8IJ55nt/r7Xw/vSuno9+Q3+CjPJ3DssAnmT?=
 =?iso-8859-1?Q?8gJYsSZqwruNdFvvMc9Je52xxug5uKDx0xCDWC2AyUIK+QZT/A1+RkWhCa?=
 =?iso-8859-1?Q?EnZcakc5625WMrKWb04UWmbY9ekDeJqUHpp33H5ei1s61ABnqh3i2D5A/L?=
 =?iso-8859-1?Q?eSZDxOBWhwCTzhSzuaZSDjgUieBDS6RHVXHLlv8ianhXlukEbPqf4/av/5?=
 =?iso-8859-1?Q?Toq7Ud/fjYuF1e5GC4l751WUzX1l6xsv9tBUZpoJLe7YMTyywrGzlQMkrE?=
 =?iso-8859-1?Q?u6Gb55j5R1qsmOa7xO7IapZnUJRIEPz+BcDTfiA+YXg3uZlHeHWt8fnEGs?=
 =?iso-8859-1?Q?2xviw4foWM63UqiDOZ9tM0VXucfm1UcPg+wRli4xn40GD0uSVVhHAS/MqL?=
 =?iso-8859-1?Q?UE/PZd5kiRhwj3c+ZEj0U3OKbUReMo0S/wtQNvieeESzXNwqicJ5VbpSNL?=
 =?iso-8859-1?Q?eAzHG8z8ePEL+TpsgrQT7CAcbtHsY14T1yfwpphxSPp1zIr84f1vg/+2/p?=
 =?iso-8859-1?Q?feQfuunfvM9yXsmubILokxb1b1HI27A5oxJyaXp4ES7CfSlQJwzeKV9eD2?=
 =?iso-8859-1?Q?OhH94C46FTphtq0gaovriyETkap7Rh+IA/KwTkfJ7FY5xwM37NNa7CEA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: zigngroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR08MB3089.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51d5dfba-9ffe-4bea-2c92-08dbba89200c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 09:57:11.3503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ec7f600c-e944-4b82-8191-695b8f02591d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xKw/NuEgeX2BwJKhageFDNZBRxsUF1an7ZLLl+rIhetWvM2lyTEVGlIj51NYzxS7K+mw79NlBndp6OJi0O4RDhsjqYwUZ9Y9bZNk4lCecRs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5631
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

dev_warn internally acquires the lock that is already held when=0A=
sdma_update_channel_loop is called. Therefore it is acquired twice and=0A=
this is detected as a deadlock. Temporarily release the lock while=0A=
logging to avoid this.=0A=
=0A=
Signed-off-by: Tim van der Staaij <tim.vanderstaaij@zigngroup.com>=0A=
Link: https://lore.kernel.org/all/AM0PR08MB308979EC3A8A53AE6E2D3408802CA@AM=
0PR08MB3089.eurprd08.prod.outlook.com/=0A=
---=0A=
 drivers/dma/imx-sdma.c | 3 +++=0A=
 1 file changed, 3 insertions(+)=0A=
=0A=
diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c=0A=
index 51012bd39900..3a7cd783a567 100644=0A=
--- a/drivers/dma/imx-sdma.c=0A=
+++ b/drivers/dma/imx-sdma.c=0A=
@@ -904,7 +904,10 @@ static void sdma_update_channel_loop(struct sdma_chann=
el *sdmac)=0A=
 	 * owned buffer is available (i.e. BD_DONE was set too late).=0A=
 	 */=0A=
 	if (sdmac->desc && !is_sdma_channel_enabled(sdmac->sdma, sdmac->channel))=
 {=0A=
+		spin_unlock(&sdmac->vc.lock);=0A=
 		dev_warn(sdmac->sdma->dev, "restart cyclic channel %d\n", sdmac->channel=
);=0A=
+		spin_lock(&sdmac->vc.lock);=0A=
+=0A=
 		sdma_enable_channel(sdmac->sdma, sdmac->channel);=0A=
 	}=0A=
 }=0A=
-- =0A=
2.41.0=0A=
