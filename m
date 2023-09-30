Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA337B43B0
	for <lists+dmaengine@lfdr.de>; Sat, 30 Sep 2023 23:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233971AbjI3VEu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 30 Sep 2023 17:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjI3VEt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 30 Sep 2023 17:04:49 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2072.outbound.protection.outlook.com [40.107.241.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCDFDA;
        Sat, 30 Sep 2023 14:04:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=elb0ywYu/E+R5fn/ut027LHsM+M3B5we5uc6QrpEzEHaUs73HsigoT8rxYhp8BqA5fLm18C7Wkm68kgwe/AXheth/Ku5dHeezmMOIaMA7mGC1ROJUk3yxMasXPl0O8nPl6r3QLEhtF0oPUOblrSTimFPPIp+pqIOkw0tD2hkpMdtu34DdOUlDFztYRNJljZVZUTTPx23qX7JYVcpu3sch+53LA2L+527VC+KQXDQHkf386WUiFbJLhwAAsuO11cZ7YcC+tEeIrKJNYl/4qm3F+KTsXRX1MjhZisPBxvm4Qn3tImkKia7fIj1gKW0QyhZwgtlruqSufdqJTyc3nc3eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FTjTJtpWpFcHum62LjGZVA25Ooo/q/BNsM6l+LWRPm4=;
 b=Jxo/5V9TQ4IG0em/yF4yp3Q4C8wzth67KaARUk2Ypx2/XkKJrRNEe37POUvOk+Tl+hT3EA7KNI9cgRybCC5kRpg0MNq3SKFJyhyfgxSmvTiiMDYZrFQOKi5DcmUDuxQ+07m+5hVMmbltZrpyy0PYfyh7iV0E0rvXEK5niiLzjixk2O03XxZ4uaUCvXVTBn3AmMoyuyn+CfQhdS4GcLV1ZWXeGVDCThBbsxN9AfJgcehHirUtggBtoKOA6KTLf1fO51JmrKT8+Q7wwPefmdYPHjbRlVTsBoyJWTaMMmvOtX8cPK7Vu8qP8Tm2lBUy8P4Z2xueBelfvNg94JmUnf5Idg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTjTJtpWpFcHum62LjGZVA25Ooo/q/BNsM6l+LWRPm4=;
 b=cAqdyxsZmEFZat4r8NxKlmo4aGaP2lfH9okH1MXtE2icFp38FO/cvOiw4nzOgfa1MK5Yc6m9Qm42pMXnQI1EnA4xMuw51RdX10J0cxRXOs/OnOwK6uea++B9c8AMoOKqrAZ27CBVF5VchUR95FR/l+mdlGJBFa7sf7LvQ9mvDUM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PA4PR04MB9246.eurprd04.prod.outlook.com (2603:10a6:102:2a1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Sat, 30 Sep
 2023 21:04:43 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6813.027; Sat, 30 Sep 2023
 21:04:42 +0000
Date:   Sat, 30 Sep 2023 17:04:31 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     vkoul@kernel.org, bhe@redhat.com, dmaengine@vger.kernel.org,
        imx@lists.linux.dev, linux-kernel@vger.kernel.org, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, rafael@kernel.org
Subject: Re: [PATCH 1/1] fs: debugfs: fix build error at powerpc platform
Message-ID: <ZRiNXxz4NlN6LBXt@lizhi-Precision-Tower-5810>
References: <20230929164920.314849-1-Frank.Li@nxp.com>
 <2023093029-chalice-violation-c349@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023093029-chalice-violation-c349@gregkh>
X-ClientProxiedBy: BYAPR04CA0013.namprd04.prod.outlook.com
 (2603:10b6:a03:40::26) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PA4PR04MB9246:EE_
X-MS-Office365-Filtering-Correlation-Id: f6f96c89-921e-4762-b227-08dbc1f8dd6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UR8fxSwGw64ChzXojD3/KMizRXFzqDBz5e/+F3ASlPWbKBDbxyIFQwM3ZQPXFU7X/d4ZSW2MnYomkYiHDzZ0UJgy6GFgNEFNPY7X2Fow3xqQV5On7KlUNWUfPkMESug4VrEFr0JHhkqoLsK16Qz0/MX4/06WZNUDnZ9YhSvx+rwBbYOSVFz0cyS38Mdewhs+2AEDgOVfcYrT6yFICFxllz++7Qt0JI7L6oDRlvLsfi2uYylXNhwpVAvDR9R255ofG2GBcY6P2OSUKGuEW8pTKqKQk+fNdHrY9WjcvyFyMVy5Hqw2gBU8M+FG+kLXeKdKXcNC4Frj+Y1xmxQhyiK8Z089p6WGgCyqJaBVgIM0K2+TBVsUVQSu5XnS1i4uHlq/hNJHQvNfKLpw367QlxnuNlvbui013WDiztNSualnr+xssE7niIX7MeWPJCTdr8ZgZZgvaIYH4JRZWsJrZ2DwcPFjENP2XS/PRnoLNFPhYzcZR/0Vew23w86b3jEwETUC36AcsjnImynnvXrhb1KZWHyyutAuB+RWRtPC0n0UxA+HiVSUGuEO8WU5fMfsDZk42OIUGWRt+ktvHnomnHDkx73OcTbh6MpMx7p8Srg2nbc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(396003)(39860400002)(136003)(376002)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(2906002)(86362001)(33716001)(5660300002)(966005)(6506007)(6486002)(26005)(66476007)(6512007)(9686003)(478600001)(8936002)(8676002)(66556008)(41300700001)(4326008)(6916009)(52116002)(66946007)(38350700002)(38100700002)(316002)(83380400001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RGOhqh7i7wVgFhwaca52KhGSlc8uEH/RioC2mWLZGnuZVWk8uoZwDBGYCWwG?=
 =?us-ascii?Q?sO+U0ZoYdVrW40IRxe56G8QnSWxxFH4kiAhB7nt94ec5a12pMpiAu+W/Fro2?=
 =?us-ascii?Q?VUapvC7Z2/Ui2uPCzYl7obqz1A8uHd0db7GB4h6CZlhnyibLhrdUzVzeC6nW?=
 =?us-ascii?Q?VsZF3pT/xlk27CsmcSw6GuZhOUi0D5KYDU7AXW98zleHb1BGbjB+H9nAn/tj?=
 =?us-ascii?Q?HLRJzbeZROx5FVAT6mTYNPja/Xw5X0GrUkE9wlTTQFonnIE+i+vojOa95KgR?=
 =?us-ascii?Q?vnfhM633E3alV4bu5OrlbAt7bIYuJ4NCHFyUU3tkxdUFF3LXHqCMfCPKILq6?=
 =?us-ascii?Q?ne+C9SI30VVevYCFhLPX7ffq9yIR+kY6+h2sua9Rq/6m9EKuv6GiH15RkC9D?=
 =?us-ascii?Q?Y9LpeyzWzCxIxVKz9zH84vb0FgHzRdG/MNBR2njGEghBLBB4Qm7DdIgXR0BV?=
 =?us-ascii?Q?CXp1HHWhCrf8QU6eRQ0lWFIZyQAyLCA08BRxn+pSH6f/Z8AaPTvpVLqSeDTu?=
 =?us-ascii?Q?pLkGz/FlsgBnr6IbHzZZ0Mdt/YptpT+HekOQhYHSWVzjZ46NW9TKayoTYcJg?=
 =?us-ascii?Q?V0aS/ntVcO1izucIed1p1CGHNGDxc6JtN3LBbwkP7nhepTqRRP04Yvb1GqYE?=
 =?us-ascii?Q?1pXY0QSro7tFQyx5EjCVpMZkqjsTB6b4UAzLNLXBBVrzhwZlUIBk4DIUByGS?=
 =?us-ascii?Q?m1srZPlCOg3xv1IRZav2jr6qVIfHPdi1J4+P5QNkmQnzeGR0z/0zQ4z4OsXe?=
 =?us-ascii?Q?PcEBS2krhNZljXpJC4bE8EglFRkwohfoyUo9bSge+gi/V7l6s5lz5EyAJ15k?=
 =?us-ascii?Q?zVGPTfAkX40x5/AfwYUsCwUEmmMNiGrC4lmPH88VfDj0XIncAmmssfTHfiYi?=
 =?us-ascii?Q?PYaVW6RVRfaXgdtkz5Y64jpFToBZNBCqK1ggPgJ7AbtNv7DVqP+s9u4JT/xN?=
 =?us-ascii?Q?ZxLO/GSTI/YW1Ui4l7KMbxigtOtyVvBhBImmC4kvvk7+Sma0liM8jeRVPKTa?=
 =?us-ascii?Q?kGoMkN48rgqQMzxRPoX55pa7SfGkXXSQnMBcpN7dDqwZuTacH6RmY5w2X8lh?=
 =?us-ascii?Q?+m32BNynxbr86/VzhYPjIKD9E3rydFf1wUTnC9/6zTSV74syeHusHN2lXdzt?=
 =?us-ascii?Q?EPQKIe1LQaY7WOTAQNRWPL8Z/EmGxh6Uxw2EuPgVF+Tk3RlwhWd2FlYiG8vH?=
 =?us-ascii?Q?Ec67sKkAEW/trHTyFU2AW4Wnj3OLyvsXJdzt96hMC7TFl4caFuva4a8O045t?=
 =?us-ascii?Q?t9HvOZE/zfmR8CfJrK/YhK9FoycLTsSLoEjCYfptgcLFc1UTqqpPQqMahUTP?=
 =?us-ascii?Q?iw8H4LF0TLYZ2LIHya0g+EzoNQl1b7sIU6lCYWBtIe5Y9MlcOju/k+23AqeP?=
 =?us-ascii?Q?jhjXJ/s5DRWR0HC0gGVt1A+CvQMVjttODtuNOmtWUeJRNoTJAzzmHy6KZnlD?=
 =?us-ascii?Q?Gk4tN/BRq96vknaZjvZZM2xvVfWgoh3jC0tqbd3ayqBPMThkI2+18IaP/c0C?=
 =?us-ascii?Q?IUvxFdU5C+73f8LKANdxdwovHanYtoTjxL4+19xQh8nVn/DRB4wr+05t72X7?=
 =?us-ascii?Q?1jtWkCmpApKWCSfDXBI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6f96c89-921e-4762-b227-08dbc1f8dd6b
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2023 21:04:41.5741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LWkOopXD6q/6tQGxymtBNQZ/DNhmJKfjsHY0l9KRMSaZ1ohmmKEO/R/VwSY0ei/gez2sTWJt1/dX6vtftfMWGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9246
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sat, Sep 30, 2023 at 09:11:04AM +0200, Greg KH wrote:
> On Fri, Sep 29, 2023 at 12:49:20PM -0400, Frank Li wrote:
> >    ld: fs/debugfs/file.o: in function `debugfs_print_regs':
> >    file.c:(.text+0x95a): undefined reference to `ioread64be'
> > >> ld: file.c:(.text+0x9dd): undefined reference to `ioread64'
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202309291322.3pZiyosI-lkp@intel.com/
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> 
> What commit id does this fix?

In dmaengine tree https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git/log/?h=next

commit 09289d0ad1226c4735f8d9f68c9c3e54cbaba3d4
Author: Frank Li <Frank.Li@nxp.com>
Date:   Thu Sep 21 11:01:42 2023 -0400

    debugfs_create_regset32() support 8/16/64 bit width registers


> 
> > ---
> >  fs/debugfs/file.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
> > index 5b8d4fd7c747..b406283806d9 100644
> > --- a/fs/debugfs/file.c
> > +++ b/fs/debugfs/file.c
> > @@ -1179,7 +1179,7 @@ void debugfs_print_regs(struct seq_file *s, const struct debugfs_reg *regs,
> >  			seq_printf(s, "%s = 0x%04x\n", regs->name,
> >  				  b ? ioread16be(reg) : ioread16(reg));
> >  			break;
> > -#ifdef CONFIG_64BIT
> > +#if defined(ioread64) && defined (ioread64be)
> 
> Are you sure this is equivalent?  What if these are functions?

Just dump 64bit register value. I am not sure why powerpc have not
implement this function with CONFIG_64BIT.

in io.h

#ifndef ioread64
#define ioread64 ioread64
...
#endif

I think it is better why to check if ioread64 exist.

Frank


> 
> thanks,
> 
> greg k-h
