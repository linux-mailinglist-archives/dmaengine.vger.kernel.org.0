Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634D154C9EF
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jun 2022 15:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352738AbiFONgm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Jun 2022 09:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352387AbiFONgl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Jun 2022 09:36:41 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130074.outbound.protection.outlook.com [40.107.13.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30F5369C4
        for <dmaengine@vger.kernel.org>; Wed, 15 Jun 2022 06:36:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i5tPeKOlrQuG1oPWdimXo95MQlQnLkXMAZzDJxVpZqd4dW9NE0/5MaB+3uODhoV9XBQXeTJJ37HEANXtFRmqKH9Woz+ablxS1cwy7588og/6qGdm3ta9zIeXlJi5Kul+YjPcUR186zhiH7ddQtshRhjwPsLCEe7b4D7x99xxM7vhQhPYqv3QSH57J/xJvxOKj5zUSEu7SY8Y2CsFCFaGDnPlaTqrkSwad1c8HRalRu/Gkfzm1Uz7Ks6ccs6lo3bL0rK7EyvLrlLUhExZfqhiOINzdiMJy79kkrsCe/8T/YTfMDedEOmdirnYW95NC7CjlfkeKwImKEjIKkHm0hvB/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OhTl4f6yV3MrNeLzKrQsXlBtH2Lm8dteJBL5gPxA0Lo=;
 b=LClaPJuChDVM0RzZZHWzm97P05WvS01GAluws+1U5LAdjSt1pLo9vz0f1tb9MBY1vRXe63YhTKAI+ozvD3k+mCeXnP2NUoixy7qgEiQCn+HTlnhYYkvgub6Wd2uljR10r9c8v2SsdapbzZeMmcp0RThm4KTNyNrLos3xTxNPlsXy+quDLggE65XCvHBKKfEJTCDwv3c6Zh+NhlkxMVJzrATm6/Cr05XK+L9cmv+l++wsn4jFU1dtl7tn8KmtpDsWP8qYh2BXAMIgcO5M312m31qeM8r8DJt58AfN2EXm1WqTVtChk68AbxZhWCp4S+xDtToP+5ZkwQPbM2ldeqERMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhTl4f6yV3MrNeLzKrQsXlBtH2Lm8dteJBL5gPxA0Lo=;
 b=GAqxuVXXErgA8loxTn1ec/r31MoIh275H/R4kWCzvuzrjNLoZzTAQxfCj1i0d/veHMSYObLvZtPhct7hQyL9dopYIwZowj9Q/g2y7vmBxdm0EfwTj37ThG0DLgAifklBtpBDxNmWIEcbBF9XZXw2B1BALPbojlXRcJY9dsusi/E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by VI1PR04MB4319.eurprd04.prod.outlook.com (2603:10a6:803:43::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.23; Wed, 15 Jun
 2022 13:36:36 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e0bf:616e:3fa0:e4ea]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e0bf:616e:3fa0:e4ea%5]) with mapi id 15.20.5273.022; Wed, 15 Jun 2022
 13:36:36 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     lznuaa@gmail.com, vkoul@kernel.org
Cc:     vladimir.zapolskiy@linaro.org, gustavo.pimentel@synopsys.com,
        herve.codina@bootlin.com, dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: dw-edma: remove a macro conditional with similar branches
Date:   Wed, 15 Jun 2022 08:36:21 -0500
Message-Id: <20220615133621.28027-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220610100700.2295522-1-vladimir.zapolskiy@linaro.org>
References: <20220610100700.2295522-1-vladimir.zapolskiy@linaro.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0065.prod.exchangelabs.com (2603:10b6:a03:94::42)
 To PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 144725c6-c4ef-4877-ffb6-08da4ed41185
X-MS-TrafficTypeDiagnostic: VI1PR04MB4319:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB43192629B663CBF9306E1FF488AD9@VI1PR04MB4319.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DAPHrcU8GTpvC1RT/E2lJci+DPhNWEy1zRjEoEbsuP34eAlQIoBjRkOBZ0osypU9CSl6aYEDqTK6MN3cDZ2DOzRTKzsK6JJQ+Gb4jIJJXJTahMET0MOB31ZC0YWhQOopXmuUNRMEnaZfXYdieF+lPQIg/j0UdnfekBeNDmisIzjVShOovTFBVFSw47+J8lx+vYnlrjB93oj0oPzBTdYMo6/tkMHrtAIP1m33ZIrUaOuYNf+aFU6y0spxaP3w6O63PLSueNKeHgWKyhrxEmqfyXYQsTFjDGdbFM8+EaPKZH4wBrzJdlc1r7/IWB7P92KFun9+hPDcCnqteOYKTnxwgyQxEV1z7ZVWGyWp9WOVYLVbz83pUBXK+4nPs6eN//grlzDKaX2cJ425fNul3lpQEm1L+c+JT6MDO3A4nqfd3478znIpkWEYeBM8d1yxPJ81HFkvfuTEFKWndTbfL9JeKGbZsGCcsnYaIhiwPO/UamCaKXZJpKMfkWqqgyYSUkdLvn6WQ0OwOdhKVK2uUEJ+Shs85iHdWfKrq5YzW3Y1q8mHo/dsqLvwQlL0q9bcFGqdedVqNK+Ze+qcWfkEJd+CsdZhrSi35z2jlbMk/LnBmzU9nWqGOwIYkZ5a8kwtq25qAEg6nbDO7EgedNID/dZsEUHQJ2EHPB++qOmxDKRIpVuuGjJKyXLSG4ArnnO9hfcZh5muKANdUoJ22yIr/rm2hcIWMp5PgQqWPUWzuJKHatSVC8uFLSi/16LFrRIfssaJ+E2hHMbaHLABzTBqbk6+WRqn+mlWkenMTYJx7BGdUl2aE5nMZJIghswdTYTyD/LLo3zMQdFV/gUZ08UnhmGqEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(8936002)(2906002)(26005)(53546011)(316002)(186003)(6512007)(52116002)(4744005)(5660300002)(83380400001)(6666004)(6506007)(1076003)(8676002)(4326008)(2616005)(6486002)(966005)(38350700002)(66556008)(66946007)(38100700002)(36756003)(508600001)(66476007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R0TDb0MS4dv6tCbcf/g2QIdLQOrqkfcOSbnVr1djMPYUK9pemhtfc7wPskAa?=
 =?us-ascii?Q?LKq9WhsUcU17t0C/n0Gws4tB1nsPZEpAu+VG0h+al3Bk64fQ70pyhaltix59?=
 =?us-ascii?Q?keRcPmweK3iRb45+AYYZrAm+cqTUF2IQ9RqgFnjFvnrvKF/3NubkdC15ucfo?=
 =?us-ascii?Q?HNBXZMixUDHd+MHyFLX4FkiTW9PIpsh9kgcBYAzXkaQCTm/wnuz8EuxMx1jf?=
 =?us-ascii?Q?NYyySfsP3ozoYNN6SZb/IPaFiGLH37NwFapOe0azkoPd794Xh/81/uJal/go?=
 =?us-ascii?Q?sjiERURQcrTYaPYs6Ej9iwRl1OGoHL76aJp+y0Nbqzem8pzPLGmgi9+KFhwS?=
 =?us-ascii?Q?Of63tcVsJaDVFVKYz8JMj9K+szo1lI0Wki7ZDwYnSWcfBOX8YR5RgYEkdZlU?=
 =?us-ascii?Q?N3zi2OtbEEOl7yeHo0QqhOEmpqQh6mNJ3WoTKThXQcQ9DgGPrhs/z/Naz4kH?=
 =?us-ascii?Q?IO4Q3E+fFNTW09LHlndqAbTFPR/SjvlToXBex6OHeicsqY1IASgndtd+wQcR?=
 =?us-ascii?Q?cRB15BmW4tUnFRwGUHVpqmbKMtkR4nP3MrDD0xzOkVR7pz87s4kar6gDsD6n?=
 =?us-ascii?Q?gJvpC5ZY59R7LxLeJY+z3ot4khLT7RzeQwb1ecVvAmB2EFIqXJqu0irMj9c1?=
 =?us-ascii?Q?xDICBckV35O+KzHAZBAaTw+ywjrcukl71r1jxYI/KQyqP4NvqGrzpnPFPeD9?=
 =?us-ascii?Q?HAEwaZobdpUi6Cj5nbmnY0UT/bTqD5h7VkGiNVvBagm8DdfSSfEpviCxK7cT?=
 =?us-ascii?Q?jleZQWG4ZXGi9Eb0YBrNNjfa2RpErPCLJD7nBSz6H48neqMmm+7FGM5Qev3w?=
 =?us-ascii?Q?lrJxnvG8jGR2Be3o2lodxfHHetJpX/Yr5BM0OXaZI/O/lIebBMf+f8id8MBB?=
 =?us-ascii?Q?zNQIbE+VLnYgKoVfrf13ehUuP2aOZW8FujcXXhKyX/RKKSGaj7neMvPwAneT?=
 =?us-ascii?Q?LH26w36QILefX6DJeAhomT6Sea7aA0B9qS6C6/IkOKTXHncHqjbGA49Gp3+E?=
 =?us-ascii?Q?HcBmOgbsSOAdqdfNAfeGyApp9Ae9DsC0AkpesMGUzxCuKxCv16At5iddBI0R?=
 =?us-ascii?Q?69EXiViN/JkZsi1Hh28vETeebEGhrZJbyT3hnJit84L9qoC6frblRtwCaADa?=
 =?us-ascii?Q?VWZWdrLFhAn+VGufjRLt4ZE06MLDBtetiajoAFRXAddKvAsg7uaEExUl6Jt0?=
 =?us-ascii?Q?DyJn4ntbbQGPb5qFu3PPLqZTvXI7gos0Pkf0kq06PQrkL5wN+SDUpmVbfzIX?=
 =?us-ascii?Q?klXaQjDOXm6q1toMPlNypj4ozWd00/3r+xs61PGwmaKXX6MxOM2dnKH1RSfZ?=
 =?us-ascii?Q?I/Gvil+xgTwxZzujkkmdJBJdO+XO/0I5qz3vXW8GiJE4UA3SuKrKNd/Of7MN?=
 =?us-ascii?Q?zKzb0xjuubq2TBsSVF8Zb0ywOOjrnyTOhu1v01XUCpGQPQfDcBJZ5yPXUwMh?=
 =?us-ascii?Q?yhtMkAi9QmB0GbRzURn5rukqXmdf4S0a3aFMO5RJOpHvfuBXL7j6AI43AYSS?=
 =?us-ascii?Q?T6KCXkZm+fjs/0zHbQPLASw21/KjlCV2WJIS9iNpx0SPEoofcX6uaQy0aXWd?=
 =?us-ascii?Q?dh1hsU+jl8rFmksSAwJQ1mv9hMfVX3/M5Zg92XKFcBjW1LZeHUuP80RJLecN?=
 =?us-ascii?Q?QVNu2wfkhJBjYxHPVi7G8D/BrzcJ1sfhPQQPhsg3CzZ0M7sv3xkKAYrQZ65F?=
 =?us-ascii?Q?g5HyYvtIz8omJXhxStEhAciocXayBW8pomEB/I77Bl0HbcOuTsjAjXAQJUyF?=
 =?us-ascii?Q?dOTE8Ky9Xw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 144725c6-c4ef-4877-ffb6-08da4ed41185
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 13:36:36.4763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VHUoR5GZe0rm/6sAbpd7pttlXmVFkXm/etbtcT6XLdj3ulzU4fpnBThypiXsQOicUlgh5VaIfy5atbslc6w0/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4319
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Jun 10, 2022 at 05:49:36PM +0530, Vinod Koul wrote:
> On 10-06-22, 13:07, Vladimir Zapolskiy wrote:
> > After adding commit 8fc5133d6d4d ("dmaengine: dw-edma: Fix unaligned
> > 64bit access") two branches under macro conditional become identical,
> > thus the code can be simplified without any functional change.
> 
> Applied, thanks

@vinod:
	I am very strang!
	why you pick this patch, not pick one this one
	https://www.spinics.net/lists/dmaengine/msg29735.html
	
	both patch do the exactly the same works.

	Any no any feedback about patches 
	https://www.spinics.net/lists/dmaengine/msg29913.html.
	which already review 12 round and test at three difference platform.
	And at least 3 person working on these patches. 

	At least https://www.spinics.net/lists/dmaengine/msg29914.html is cleanup
	And only two lines change.

	At begin, I think you don't care dw_edma at all. 
	But you pick this patch. 

	I am quite confused.

best regards
Frank Li

> 
> -- 
> ~Vinod
> 
