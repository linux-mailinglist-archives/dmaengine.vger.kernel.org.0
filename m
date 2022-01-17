Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 794B84904CE
	for <lists+dmaengine@lfdr.de>; Mon, 17 Jan 2022 10:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235648AbiAQJ1H (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Jan 2022 04:27:07 -0500
Received: from eu-smtp-delivery-197.mimecast.com ([185.58.86.197]:38706 "EHLO
        eu-smtp-delivery-197.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232585AbiAQJ1E (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 17 Jan 2022 04:27:04 -0500
X-Greylist: delayed 406 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Jan 2022 04:27:04 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camlingroup.com;
        s=mimecast20210310; t=1642411623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=h4bPA5hs1LxafEBUzJ27+n6czQX4qqm1veWrYGM6Z3c=;
        b=byGuKDFJ8FHvKVYmWhz/T++D2fEPqDp9MTP/Q6tx3fQyra/18qx5mgeQUufUaBsZs6Gc/g
        eO9zav2Udto5743QCZAzH5m8TPr3b+XtJJdCmKRmjrBeXNYv10Qi/76YKNkZ0LRaeUKMm5
        Pm1MKU8Arx4p7d9EHheBBDncZyW40H8=
Received: from GBR01-CWL-obe.outbound.protection.outlook.com
 (mail-cwlgbr01lp2057.outbound.protection.outlook.com [104.47.20.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 uk-mta-117-IiaRZuJMNm25TufVaop_Xg-1; Mon, 17 Jan 2022 09:20:16 +0000
X-MC-Unique: IiaRZuJMNm25TufVaop_Xg-1
Received: from CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:16b::6)
 by LO2P123MB5789.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:250::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Mon, 17 Jan
 2022 09:20:14 +0000
Received: from CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 ([fe80::4c56:90c1:1ed:2ea3]) by CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 ([fe80::4c56:90c1:1ed:2ea3%4]) with mapi id 15.20.4888.014; Mon, 17 Jan 2022
 09:20:14 +0000
From:   =?UTF-8?q?Tomasz=20Mo=C5=84?= <tomasz.mon@camlingroup.com>
To:     dmaengine@vger.kernel.org
CC:     Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        k.drobinski@camlintechnologies.com,
        =?UTF-8?q?Tomasz=20Mo=C5=84?= <tomasz.mon@camlingroup.com>
Subject: [PATCH 1/2] dmaengine: imx-sdma: restart cyclic channel if needed
Date:   Mon, 17 Jan 2022 10:19:54 +0100
Message-ID: <20220117091955.1038937-1-tomasz.mon@camlingroup.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: LO2P265CA0256.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::28) To CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:16b::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35925791-f83b-4c96-d103-08d9d99a91e3
X-MS-TrafficTypeDiagnostic: LO2P123MB5789:EE_
X-Microsoft-Antispam-PRVS: <LO2P123MB57893639E6AB6A6737C7758D92579@LO2P123MB5789.GBRP123.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: e1TRbN3sysD4asv+q0lAB3Tiece9kDmdiCy4nI80m3EfQSSBWrQN2g4RgSDg1Nx0RJSWBjTSnLN24hpHgRQ80UFQmMO/qTlnOABsT5SMma+vK+rNLJs1LH4ZJDTKbLa+wt7jeCe4175EHZZsHjYCodZZMW48CA/Aachoot8oVt1bPSt+25OaPtLIbVuYf2Ult+HRVlxDsPVnSLvBZzVpVwrSBMQyaj53AHoDDCsxbKn2ByHazSRXpvOWzUk5tPsDPV6NJ6XNKXXjXtGP8hDpAzexcFiAzkEHw6995EBKwGQ3qIYpALhBLcA8p0DUeLoPkKNLHr/5lfuDM23nsJYzwXHi5rtSlwfQuhI4w6NkNasF4NGyALXRjEB3zqwW1qJ/gMUyqjdpFXAUZOxJcaISgWQ7TIGEf1BlCy3EDzOekGznp0n5TaV9trmzlOhu327VYdL4uVkAqwjSTf9TTOfxaEr/sJNsgzeTMHzU1pipFSwaNWrezkwfhRvIwozs79pWaQm/4m3UiUzmWgZE0W/DWdO/dOk5mbtuevT0tvi2oTtVtIMJFU7WqQjg6nKdt7d8cHEAZEwdurI/Xpdj6QeSQzPeLgbbbN8uKjwjiBiTxCL09ZE6ZTN2Qah2RvhP+6un9PhIZMVtH2MNPenDok/Uq8EAnzem2DjKa7gvi4B/KcZcbPsOAyoqbM+e6JacAmphSK/o+Kx/GWlVM20g6fsn6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(54906003)(66556008)(26005)(6916009)(66476007)(107886003)(316002)(66946007)(83380400001)(6506007)(2906002)(186003)(2616005)(6512007)(4326008)(86362001)(6666004)(508600001)(52116002)(1076003)(5660300002)(8676002)(8936002)(38100700002)(38350700002)(36756003)(6486002);DIR:OUT;SFP:1101
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kRkTRlaZtKxjD0+XOlVJh7SDXYX1CrYatTafIVbFarceTciBSZgKav9Eqm+z?=
 =?us-ascii?Q?VHWTJiahc1NkruN3CEUoaSXXT2r1V+kTEtRkx8XsG3AsVTeqhGuEcDkYWNO4?=
 =?us-ascii?Q?VvC/DcH84a1AVOpXtciEuRVYzJ5A1iLNHJPKUU1NDv4hsBaOIbHEeoXgOz4e?=
 =?us-ascii?Q?1pjPVIkgFAf0ciYzXwbgwwnXZEBkoKB9+ZgnIKS4HgsrNdIAXWV+DRZTJfb8?=
 =?us-ascii?Q?r7RJYE5g3sEV3woPwqXq8FxHic2LCgKc0OHXJ6appZr76eYXoH3vNsu8Q4dj?=
 =?us-ascii?Q?MQEolXtEl7B4n8uPjestPV1umxdghAUOKj5BnFnc+98Ep+WMk9NZb+eLum85?=
 =?us-ascii?Q?I0JRQ7/w2G7sHRsHlYt/83/1jIoSadn0X5sV9zbNBE9yG8KWptY+gVF2oMPd?=
 =?us-ascii?Q?e8RGdg1yuJCJTqMtGmky7qdGu1Umi3suNo0oF6cxrqqXzRIBiNilkNj4izYp?=
 =?us-ascii?Q?UPbW9rHjxMDTcCmTgmjLkYRI2BolFMxfPjjP6KOm5djAKABLoALpzCX4hQzJ?=
 =?us-ascii?Q?3255JtY+ecql/44fs5na7T4Nc2bvz/vEqnCyIHAURiEZbSV/QniCdIwPtOYX?=
 =?us-ascii?Q?+lHN/OQMKnJ5R/MIAzrXlOU4WZrzZWotVpP4bzAqNZfNmWFhG7UzT3IHDLlJ?=
 =?us-ascii?Q?spFMQ17/fNMmcaIXWJgEoTPgybalGyiqGUvCaevrHFjNkpPPKOut6UweFu1W?=
 =?us-ascii?Q?nkunVwrzcn7qSVFD8F8xhsWsmO4wn3h5CcizbwJJtzMA21KMR+F4PuXIcTJh?=
 =?us-ascii?Q?b9WuQNoWGQihAfhRDDvupp8nt5PWScdE/hagWtKum89MS9wsH3FnFDKk/wf2?=
 =?us-ascii?Q?s1j18aR5ZyPquComdzV9s//JN9ZRxrDbQ0rShLHsPmFZhuNeVz9GbXmLq6aC?=
 =?us-ascii?Q?oiS3rlSIyyUaQiobv3RRgdPlEFc7nzZjwvBmk5kLesgAYUWv0gBDrEj0S1Mx?=
 =?us-ascii?Q?pKbK3bVXjuTXmh2MnUYpwwJzr1jvQcHxAtmnHp6ULbQ6e3wKvqR1VfNjTlI7?=
 =?us-ascii?Q?fkKXd6CsjJDfhTswcFQs/DoP4afqDxfa5ZsoneZyJx7xQRbMMC687d/WwORC?=
 =?us-ascii?Q?V4dhHnLXykzTM99K4/AtrEXFQWgUAAE7kCNlxdhKVDAEo91DenxJYZs4L3F6?=
 =?us-ascii?Q?0YjJGO5D4QWblrEeHAqCdgkK4gxjgjsgb2H3lR6RE8NhJbvKLyZX3C9/bFrX?=
 =?us-ascii?Q?zPBdlCGE6sZjEcftTqcxgpUWsEHkGyLj54hgmFfGkuGETWuC/v+Bl8CWI4ah?=
 =?us-ascii?Q?dlqVtiZ+dfUX0ZGA4G5Zvu6/WjPINTvJ4r9/JoLAAYbmVZH9byacpJd/gFEg?=
 =?us-ascii?Q?HMaAeNtWN1Q8ZB61/DYx1lwZIOmFdmXHQHIVPfTFTTPNzyepSET0GrjP3k0Z?=
 =?us-ascii?Q?BXV2XCEITE/QJ+xJ1xIbM3lxiTPeozfUQcPRVgBGv5aZmypV0he4DKFHs8Va?=
 =?us-ascii?Q?U67sPNA5NIg7a8NH0j+Lgm8+CBOGryWaf9/NDDVRXXXMTKlO0e95t1K77sT2?=
 =?us-ascii?Q?euBrMIrD1EH4zrCZzUi0b5khUCWJsmSDlhdRCT8q1gacPv4er2HqaUHfGGf2?=
 =?us-ascii?Q?jarMn0UpK+w/n1vRbOHURWzW69+REIZ3xRX4STxQafQWvHf6LjTlF8HLJYlG?=
 =?us-ascii?Q?BBiFtNhZwok41K1RHngdIidRnO3k/l35cc8GT6EybuPzGMc8W0VAujKLbUmy?=
 =?us-ascii?Q?8BAAJQ=3D=3D?=
X-OriginatorOrg: camlingroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35925791-f83b-4c96-d103-08d9d99a91e3
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2022 09:20:14.7171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nYzolRpHQV6sE9jNg0g71iDFApi5YrMb2Va13kSu0IZsVQXnj6wfZd76mhvJ7+zie4y6QWaK1prIAJEleBSLqqG7XwvVMWc+GSMuXBlYdFM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P123MB5789
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUK97A341 smtp.mailfrom=tomasz.mon@camlingroup.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: camlingroup.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Under heavy load resulting in high interrupt latencies, it is possible
for imx UART requests to completely fill DMA buffer. When DMA channel
is triggered and no SDMA owned buffer is available, SDMA stops. Thanks
to the autoRTS feature, there is no data loss due to the SDMA stop if
the UART is using hardware flow control.

According to DMA Engine API Guide, DMA cyclic operation is performed
until explicitly stopped. Restart the buffer after handling channel loop
if the channel was stopped by SDMA.

Signed-off-by: Tomasz Mo=C5=84 <tomasz.mon@camlingroup.com>
---
 drivers/dma/imx-sdma.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 75ec0754d4ad..330ff41cd614 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -701,6 +701,11 @@ static int sdma_config_ownership(struct sdma_channel *=
sdmac,
 =09return 0;
 }
=20
+static int is_sdma_channel_enabled(struct sdma_engine *sdma, int channel)
+{
+=09return !!(readl(sdma->regs + SDMA_H_STATSTOP) & BIT(channel));
+}
+
 static void sdma_enable_channel(struct sdma_engine *sdma, int channel)
 {
 =09writel(BIT(channel), sdma->regs + SDMA_H_START);
@@ -860,6 +865,15 @@ static void sdma_update_channel_loop(struct sdma_chann=
el *sdmac)
 =09=09if (error)
 =09=09=09sdmac->status =3D old_status;
 =09}
+
+=09/*
+=09 * SDMA stops cyclic channel when DMA request triggers a channel and no=
 SDMA
+=09 * owned buffer is available (i.e. BD_DONE was set too late).
+=09 */
+=09if (!is_sdma_channel_enabled(sdmac->sdma, sdmac->channel)) {
+=09=09dev_warn(sdmac->sdma->dev, "restart cyclic channel %d\n", sdmac->cha=
nnel);
+=09=09sdma_enable_channel(sdmac->sdma, sdmac->channel);
+=09}
 }
=20
 static void mxc_sdma_handle_channel_normal(struct sdma_channel *data)
--=20
2.25.1

