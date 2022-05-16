Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06893527FE1
	for <lists+dmaengine@lfdr.de>; Mon, 16 May 2022 10:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbiEPIm2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 May 2022 04:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239517AbiEPIm0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 16 May 2022 04:42:26 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2104.outbound.protection.outlook.com [40.107.215.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA1E7648;
        Mon, 16 May 2022 01:42:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KmvhwUyeBX6LTIyKUBKDuMhwCDZ8hyL8ecP6qS5EdPtA+iJuIjUX72qxw62Az8/uD/i7aEHsk+lP1/qRa8Su+nKBX+RQS1sYBL1FSZU4JSJ25OkZa6KbiAt1kk2PdcmZsOK0LMwoi8Qp3/Pm4Qn5yYlZr1CTlrVX11Q9JVX+ciXnQUKVGep9vGTgDkZm7QNJSpPR6EzBgVLn+3ml89gFwjzOlrKcHVi+oEySYdhlqcKNgLqPET602vDiW/0dyLDemHU0YoYC1GfcYXaj8pCOyMJ6flLk1iBIr5c52oYQtIhWNJLna8v9+GBdV6uBTNedEIokH3BhZkisHuQGsZMCtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zu1ZmmM8VbD5e/QYDVXA0vEgsmVCoSk1dQlKzmJXEG4=;
 b=kDGfJPEoLkOkO+zh7NFRnQBjdq3LnPwUj7CE/hFXDecdiHAV106IylHMivnyZsrkC24WaPEuKud20KFa09h3a/ORoD5KVPWBiW0BRTa0gQJR8EHefSp3GbsXRdAdbN8IHYlx8J9oVPq9BILJM+0fQRpkIiAk+sS6/Ex/wqFOYhoSePu0ZFIbC1DR6C2uBF7srRo+kZhBJ2uh+OqtoMkIGDqVCLS2LD34LAJRGC2K0ifXvlW0JnoxvGfH/gZQx/M23zqNY6sVPLrhI/uo073fYJDmo3trtBxRuNYgGaj2CTd+H2pb308+OAexYtNuRkT6PR/d/upOSODmVv0ERg/bmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zu1ZmmM8VbD5e/QYDVXA0vEgsmVCoSk1dQlKzmJXEG4=;
 b=aSekGfgVWxNKq+bTO/sOI2J+0sfBXb+lxx/QfMBogabOTtJLkE8glKIFuXnsfsEaMRErS7g8+WJ03rLNG25saAwWTa+NnoeI8Ay9Fw1+W8AaGBCktC4DdLjW+xe89EWYPZzFQeaf1h8Bju2nMCR4Z85BDNAve5NveLoIZF2+flM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 HK0PR06MB2977.apcprd06.prod.outlook.com (2603:1096:203:88::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.18; Mon, 16 May 2022 08:42:22 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::ccb7:f612:80b2:64d5]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::ccb7:f612:80b2:64d5%4]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 08:42:22 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Vinod Koul <vkoul@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH 0/4] dmaengine: Remove unneeded ERROR checks before clk_xxx
Date:   Mon, 16 May 2022 16:41:35 +0800
Message-Id: <20220516084139.8864-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.36.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0143.apcprd02.prod.outlook.com
 (2603:1096:202:16::27) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3727522-ad98-4b7e-99b9-08da3717fe6e
X-MS-TrafficTypeDiagnostic: HK0PR06MB2977:EE_
X-Microsoft-Antispam-PRVS: <HK0PR06MB29770C3E13A3B5E8D7D5DB4EABCF9@HK0PR06MB2977.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /yO7YQuklG485JGBY8pAzGmyQGJKSnKP37OXsfQP0EO2S604w9QBFq+cbvx331vRoT4mSXkti56G+ib0IafTqxtyrawIrGgfCiKzfdZgnJx8opPOZTYj7GATYGgKuH2L3gB8JfzTz8kYSu7VKBTglG7u6VGmo6GgerA9LGu/qeVCvnpqrYIBY1IgTgX8ms7SP9H02RUpJVVsAKYHGLnhnazJDEPRqmXUJOVolq5gatviJkCm19XaIqPoAowQqp91JQ/jufDcnXCWqiNREbDd88MU0yjvv2sCAEmousL4HK1sdsj6pz45N3577htC35f38gtj01z8cgU1+tCM6CKgthVQlgPyXj5/p/CHv3bpv7lP/B1s2fX5ZFd4HWiY2fpwaUt6h3Ni0KH3nVyG4Vbwft5c7p/PA016Ok9FLHgNif8G7yR6N5dI/g7ba4P1mCkw+enmgcBrR6CN2RdrjSdzvSMFzf9VEuZFIfvwOCKLkmaGOW+EdqP23cDftjmqgm12uoyZaPktJCXat72Q19sQot3UibV4YJYetVUnrpFb5znub4fs5D++Gv67ubjnPGXFIJrncMQg+r6+YObRGZzg/sffaFpdnG1Z2+WvNCQ5jA9UqnAM9jN/4QwYOM3BWMFXw1k6TsCvPx9EzYa7lhpj5vMHjhLihboU30y9LRhDJ6IG4rwg+gXMqLFBYzbSDdNjI3ze7UOsZieZELdjYc6ea5qrZpX1xNX86Rc3OBw9SMU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6666004)(2906002)(38350700002)(38100700002)(83380400001)(316002)(110136005)(52116002)(6512007)(66946007)(1076003)(186003)(6486002)(66556008)(66476007)(4326008)(8676002)(4744005)(5660300002)(508600001)(8936002)(26005)(6506007)(86362001)(36756003)(2616005)(107886003)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pYZKFo4vfMlMnBZldE3OBnkXt6a8qvK5DqotmEDlj8jI043cMRYqRbHXicNw?=
 =?us-ascii?Q?OAY4dBzEweZf8Q3svcO+66KahxAnY86hVcyM61J/xKhwoGo2QSAHDFJ1mCtE?=
 =?us-ascii?Q?jSO7q5VMUnvIRnL9+rcaiIZnkzGJOHOYNoIZx+Vxzk33shFpr4CjtesI+qyY?=
 =?us-ascii?Q?6/dtrTB76ZZq9tErzCOUA/J/4BmB31s22Nsn+Ydcu+dh5WbD4hRnN+6vhvAa?=
 =?us-ascii?Q?TbXeU9/U5HmMU2lgMbu3BzjKR22GZ2uE8FfzY3xJ63ULur3XAC6YXSBGfjqX?=
 =?us-ascii?Q?n83bnnU7jy4AFjDPUa6gZJAMRkSNLTeXO6aCIHjq4BXji4kmg6gioicgNOYw?=
 =?us-ascii?Q?TOWUn16KfZLMVUvAiWqVE7oe0+5sE8caH1MLze/zmDy/x5leGFnCunM0IpxM?=
 =?us-ascii?Q?n6A2WRQBMFsVjWTM3Fep1KLjx1kyYPLMXD3yhyQnk2uQ5ZcGtNh2YbzJXza4?=
 =?us-ascii?Q?KS2YoDlvBN7eDI9ASL7g24xYka4VUghcusQEq5PGfNR2S+MpdsYSCpD4asdl?=
 =?us-ascii?Q?VcqTlvyGcq1dVeIu26KZdDIwER7s8UsR1JsgB5eFsT9wrW7BmBbF7Cc5nAW8?=
 =?us-ascii?Q?1gMCCJSdF79yxFwHPKgzs+s4LfgSzWU78ioq2sPqXoLmb6s65sLDchfXFN1v?=
 =?us-ascii?Q?URPouITK+/EJfygZ8X3KoRcPlDCKUF8OpO+uhjcUaBtREjEO6s3XntE3UkKj?=
 =?us-ascii?Q?ROGolSCAh/RAfHOy2xGRTmFrJc+AOykjGOyiuNoU6t5axhvCoQuUTqrJRhUd?=
 =?us-ascii?Q?ZeF6g2O5XfV8ObWcbsLIO4fxLVERAN96k1D0G+GVZ5/e7wpgII65WgIoKDai?=
 =?us-ascii?Q?kP1gVQm9k4yM/qRi9SS/ez3/199ErU7AWhcwNBnZz/5o3gXKOWrO9eRIlZhN?=
 =?us-ascii?Q?ovZNhnzdvUDa7sADTJhX8gfIbjlC3r+MTShPIORbH1+d1Np2ujSy1JplQ7yN?=
 =?us-ascii?Q?KCI1aQMLkC48mwf7NzwPrMZXJUlRMlY32amYyDJ0wFbmrurr2TLQEb8L4Am+?=
 =?us-ascii?Q?uv1voBfUHf1YUyHu/3Wrr2cElZ0SHV/K0VD3SBukN2g4eLy5YurUHMlL0yM1?=
 =?us-ascii?Q?0Gj3444TI0j0d7Q7PMAl6c5hxGSM/ogevc0+tRcpylcwV7vGMXb1aleaMEbJ?=
 =?us-ascii?Q?PZeplbjFTPIzQDU2grQyVzjs44K4Riv28beMulGBhKa4Xwhtub8BpQFIxeaM?=
 =?us-ascii?Q?WI11eaA+9cMOituq/qufOTV0y1uKW5h3gY/yHIP4KCrevYhWbE4PYt8H4NpF?=
 =?us-ascii?Q?vPzOGZhL1Y/fSfeNEWqHaobm3i6XyehbMKrFy22DQAJT5/TbFb5W4/rhXZ7D?=
 =?us-ascii?Q?Vdd4sj1exDrl7I3UQzPHHPtttjhmmZG8VrZTCR56ooi0Wx/dsIB/mc9zQOYe?=
 =?us-ascii?Q?Pm+qF1O7V3iFD52/ILA0iZOCJCjifkVT8vzUTu5v6jo+holJa8F6Ah/LG0dB?=
 =?us-ascii?Q?HDeStq290GwNJFpFRu7vLgUjFywPCbFx2HFRFX03/Nkn7nUY9EWWKKgA7K6/?=
 =?us-ascii?Q?BamLJB19kpkHBdIMa5J54Qky5BtXemazCBfM0OMI0TDO4ihOxm3pNeVgn0U9?=
 =?us-ascii?Q?cxydNYWZfVIrwLwx88MTzotf6erpYqtM+JXIvXo2G4yCAB+woPn1wkeG/VYc?=
 =?us-ascii?Q?WKCdiXehBNNT3nkrDcFWFirVMhvrhaCFtbV2lRlukJb1OfAfBXCdti5E0JX3?=
 =?us-ascii?Q?seh4/Llj1A1lEctBPGtXRrWUvZUitDWCDlNfRGUK6ukitW+moIjbbxOJmh/7?=
 =?us-ascii?Q?AKU2iJPmfA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3727522-ad98-4b7e-99b9-08da3717fe6e
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 08:42:22.1282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YUyiaExFEE+WEZJuvlrZQWvoKoIS8UoDjKIX34CQZS7Znlg1sPtlEP4ozymKYZMd1+0OqnkfGfGoHw399h/SNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2977
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This patch set tries to remove unneeded ERROR check before clk_xxx.
clk_put() already uses !clk and IS_ERR(clk) to check ERROR or NULL.
clk_disable_unprepare() already checks ERROR by using IS_ERR_OR_NULL.

Remove unneeded ERROR or NULL check before them.

Wan Jiabing (4):
  dmaengine: ep93xx_dma: Remove unneeded ERROR check before clk_put
  dmaengine: sprd-dma: Remove unneeded ERROR check before clk_disable_unprepare
  dmaengine: ste_dma40: Remove unneeded ERROR and NULL check in ste_dma40
  dmaengine: xgene-dma: Remove unneeded ERROR check before clk_disable_unprepare

 drivers/dma/ep93xx_dma.c |  3 +--
 drivers/dma/sprd-dma.c   |  7 +------
 drivers/dma/ste_dma40.c  | 10 ++++------
 drivers/dma/xgene-dma.c  |  6 ++----
 4 files changed, 8 insertions(+), 18 deletions(-)

-- 
2.36.1

