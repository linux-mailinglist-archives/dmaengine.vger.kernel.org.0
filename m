Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 302A34904CD
	for <lists+dmaengine@lfdr.de>; Mon, 17 Jan 2022 10:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235644AbiAQJ1C (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Jan 2022 04:27:02 -0500
Received: from eu-smtp-delivery-197.mimecast.com ([185.58.85.197]:39585 "EHLO
        eu-smtp-delivery-197.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232585AbiAQJ1B (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 17 Jan 2022 04:27:01 -0500
X-Greylist: delayed 333 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Jan 2022 04:27:01 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camlingroup.com;
        s=mimecast20210310; t=1642411620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EEken/qdtZJOa5SSZAxYah2mOGZX8NBdbWmkYWmdk5E=;
        b=iX4iXdeSZ2I4Rve0k05Le9edrAUh+qGaj7OM7T+y3oHDN5SrLQcTqL67QqUOCfT3sJUuiQ
        Z+cfo1t7P2shlb8aEejdA/4C9pFTtqd6ndPwMyQkwEA3Q5YdmqA1415NmFy/JVkGB7gPNc
        z7B1QKMPrPMvif965bECYLaKFdPeXFs=
Received: from GBR01-CWL-obe.outbound.protection.outlook.com
 (mail-cwlgbr01lp2050.outbound.protection.outlook.com [104.47.20.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 uk-mta-185-ivMe34DyOVKoAf7pBSpn4Q-1; Mon, 17 Jan 2022 09:20:23 +0000
X-MC-Unique: ivMe34DyOVKoAf7pBSpn4Q-1
Received: from CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:16b::6)
 by LO2P123MB5789.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:250::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Mon, 17 Jan
 2022 09:20:21 +0000
Received: from CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 ([fe80::4c56:90c1:1ed:2ea3]) by CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 ([fe80::4c56:90c1:1ed:2ea3%4]) with mapi id 15.20.4888.014; Mon, 17 Jan 2022
 09:20:21 +0000
From:   =?UTF-8?q?Tomasz=20Mo=C5=84?= <tomasz.mon@camlingroup.com>
To:     dmaengine@vger.kernel.org
CC:     Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        k.drobinski@camlintechnologies.com,
        =?UTF-8?q?Tomasz=20Mo=C5=84?= <tomasz.mon@camlingroup.com>
Subject: [PATCH 2/2] dmaengine: imx-sdma: fix cyclic buffer race condition
Date:   Mon, 17 Jan 2022 10:19:55 +0100
Message-ID: <20220117091955.1038937-2-tomasz.mon@camlingroup.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220117091955.1038937-1-tomasz.mon@camlingroup.com>
References: <20220117091955.1038937-1-tomasz.mon@camlingroup.com>
X-ClientProxiedBy: LO2P265CA0256.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::28) To CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:16b::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c8a7bc4-b3fb-46e2-91ae-08d9d99a95f1
X-MS-TrafficTypeDiagnostic: LO2P123MB5789:EE_
X-Microsoft-Antispam-PRVS: <LO2P123MB5789E475053232C12B358E7992579@LO2P123MB5789.GBRP123.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: kLUGmas/ilWXjnsmbrv1GL66NaeQWoAx/Uh8fWsHwJL1JxVSj0qebtrD6aa2xBIQFYi3KAa5RDTqqXW2tMHPmV3TWcWOZz/JDzpPvOmjReQ/A+G1RsySmSxI/08Am4HxX6XFfUN8xgLr3o89kdWLORhOzvGdFQHtdN/nUnQYoM0zfZkIxvkQZ+Byg9hoju1Qa08g9Apo6ks+Q5gpddicK9Bul6coGla2T6ZVuTWJTtrrZY+zbSKgj0ib5THwqXXTOGy4pUAulR1yyPWDHCmpt5qxcD4tMq0e/NYNjBQ06CeD0E8Wm3shKvHqdaOux9djFmqPXxnynVgY9becSAPiIMlmVJ68OzXFvr4qWELhphd3W5ERxHhZxfNH0PLgnv4ZcmkNTD9Dnw9UzsW5oGQ+T5aJgko++CIQoeY+Kl1hXPzxmls3/SqJohTomErCS3pHgl4qc8JviGkkO0xs3QH2C7ivWlCk1MIr+zlWpSWJZAzV8O661PDOIWzwnkRo3mku4NOSdZOlicEQ7Wrz2PfWGsSMVNhqjCOFGLJGSgXCdtBIZBqhEw2F/7Sd/Kndxd4hmKtNsJnamcmGj0FvB2GKYIpLgg6hxsF4CPO1A9ttnYrUmgqnE9CUkPld76b91Sn2+V/h3m0dzPyiqt/yHiIs6Znueh9GpW3ODTz+ZpPFusUCyoWN3sWQM23Hfu5zbImspfQwMJKp2xBezUhwIg48Sg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(54906003)(66556008)(26005)(6916009)(66476007)(107886003)(316002)(66946007)(83380400001)(6506007)(2906002)(186003)(2616005)(6512007)(4326008)(86362001)(6666004)(508600001)(52116002)(1076003)(5660300002)(8676002)(8936002)(38100700002)(38350700002)(36756003)(6486002);DIR:OUT;SFP:1101
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hVJDGnQReYNiZ9GrpLAK+0LCNXe5MzHBssnUuZvOugZ7XlmnMyqfKt3FO7Se?=
 =?us-ascii?Q?OXzijtjdzNIyRyQ2/EqaPRWBb5pEtpfacZvxRS2+ZeknPqxNnD6BixCCHGYl?=
 =?us-ascii?Q?1cSdfoCPBdycUqAsEMkkzuZKVYpTuEtLLRLxD5h9p5utAuSTYqRmAbsuYAbL?=
 =?us-ascii?Q?pcCsxEDzsdSZfXs/wC2vgLqm1w1Sj7+D/jRPgsqrEZjpgpK2tWEk+quy621+?=
 =?us-ascii?Q?8bP+IBjfLgCpCOVujlYzPUiUe1lHY8iruxUMjexZF0+pnq4jUdoDzBUiXASP?=
 =?us-ascii?Q?ZfGguv+J7+vYknjDEnSwUCKHac3s6KP5loapzePsew6+gVINGdhjHOcFvi1P?=
 =?us-ascii?Q?iU0q8ASe+4bxuDrZe1eYqBF5syb3TdTeItWxRKIih5k5mxPTPrBdM+9BVI7Z?=
 =?us-ascii?Q?bbjlGynGdQ8hOp9vwFXxoA5yNJL63DFPREhBZE6MH+bTTatSxpSiqZ3rmd1l?=
 =?us-ascii?Q?fIkHbCVxEqJ1pfltXbkgLw0Q7T7EFbFv5+cl1t3kZQx0hFDSXB3Fe1XJjwn7?=
 =?us-ascii?Q?Q/wktIhedqkiAl/BSHzis9qwDq598aHeBc9jVWsC1CZdngLDaQ9seeyHS66p?=
 =?us-ascii?Q?UyhweEAeDdag83AWRgLM1VyPNLibQ1QysLMUgl6kKNSGnVuqeotTinmbfzPj?=
 =?us-ascii?Q?6vx92A8R8ECttqNQsAjexdEJGVzAfA+sSRBYWup04Rl39c/88EM5Oq4fc8+7?=
 =?us-ascii?Q?7/gpIQuiWlpy/6X9vkbPFh0cJeb1lijZGTTdZJAjLgIgzyrwBqWF8jfU30Dr?=
 =?us-ascii?Q?4NZAK1uCmtIZSCC+IW9wlJd+XW2tFy3N7xnaEJcmwYTQXAitUWYDXqyppE3P?=
 =?us-ascii?Q?RdWTJK0V6W3Gj+8ce5m2+hhPR1nqywnoLrG6WG2aciEeSTnmHmG9+FXsWxUv?=
 =?us-ascii?Q?CzIJBQlfaAYxpIPJf6SRxyiO8KAvwmxoikUkaXr4fbxq8tQpOuJSS5RE8gay?=
 =?us-ascii?Q?A3wRwvp2dUASfjx6LfzRL/vUk4UoqIjqlyfRS/HvgYafsejPCyHVZmbr8O67?=
 =?us-ascii?Q?TpI1GsFWaF/vOSpXs+4QPL8qpv3/P3wlPgpJ57C26UlfEFiuEw2fgx/pN1sB?=
 =?us-ascii?Q?+KTU5BDkyeQqt3GPlXAxJQ+mMcc2J0jHExpX0XzyGdxD0XDLFrnTO8eaB+Fv?=
 =?us-ascii?Q?jHmx10qdFyplQmR4KfIj/yVfSyrgr/gOa62tNKEfspsnkmCzCS4+hoZIB9V6?=
 =?us-ascii?Q?SUDUrt51sVWtcTJlbB3pzrBuFLZvlOJYdRwO6AjkFApY/eiX9RQcRKseXFV7?=
 =?us-ascii?Q?Y1AkydqRDtEUcP8/k8dF93BH/yY4FCm2qfdnC15sx3f9uszpLBFccC8dVdDr?=
 =?us-ascii?Q?HQBYD2qx3b8ibd6qlLGeaEFrxvGEhIKOquQDuJLrCmh/N4l6UGCKvSkZKsRf?=
 =?us-ascii?Q?Nfj1la4FGBncUAVRAIZYhn8G4uC2XCp+jD3sJsRfvBlaQ66MFn0pz/oEa1pi?=
 =?us-ascii?Q?4MfBNXnqxwCBUzv8UtEoBO8H++An+GVignq1BxwauUqxv3igWn8vy2Pc7wSO?=
 =?us-ascii?Q?7NjyL7QixhfEKwtIlMbar/8inKu2U9aMrmRL+8z79pQ8U3dS0BP9+FTrHOvD?=
 =?us-ascii?Q?x6O5EA23ERGkQLdaPC45A32koiXPekRsXNbLiNbYdmjvJYfJSD0dfVFfzinW?=
 =?us-ascii?Q?wt4/sx+V12iPFDwbYhQgp93h10LrXBSkHZCyVeWWP095YDt7PFJzxekPTzaw?=
 =?us-ascii?Q?yAecYA=3D=3D?=
X-OriginatorOrg: camlingroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c8a7bc4-b3fb-46e2-91ae-08d9d99a95f1
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2022 09:20:21.4244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FglsGuSi2eJ6Po2sTh1gAGah6/zddWL+6wrCM2w9HG0gRxadz1Q6QZ0pDCa+EJmLWYWVRaVR5tbsMDQtxOqtMPGW+mr7UxXwpLEHL6qBiH8=
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

Assign buffer ownership to SDMA after invoking descriptor callback to
make sure that SDMA does not write to the buffer before it is read by
the CPU.

Signed-off-by: Tomasz Mo=C5=84 <tomasz.mon@camlingroup.com>
---
 drivers/dma/imx-sdma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 330ff41cd614..8cc5103193c3 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -847,7 +847,6 @@ static void sdma_update_channel_loop(struct sdma_channe=
l *sdmac)
 =09=09*/
=20
 =09=09desc->chn_real_count =3D bd->mode.count;
-=09=09bd->mode.status |=3D BD_DONE;
 =09=09bd->mode.count =3D desc->period_len;
 =09=09desc->buf_ptail =3D desc->buf_tail;
 =09=09desc->buf_tail =3D (desc->buf_tail + 1) % desc->num_bd;
@@ -862,6 +861,9 @@ static void sdma_update_channel_loop(struct sdma_channe=
l *sdmac)
 =09=09dmaengine_desc_get_callback_invoke(&desc->vd.tx, NULL);
 =09=09spin_lock(&sdmac->vc.lock);
=20
+=09=09/* Assign buffer ownership to SDMA */
+=09=09bd->mode.status |=3D BD_DONE;
+
 =09=09if (error)
 =09=09=09sdmac->status =3D old_status;
 =09}
--=20
2.25.1

