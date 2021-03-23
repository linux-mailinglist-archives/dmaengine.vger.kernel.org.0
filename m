Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41FB6345D75
	for <lists+dmaengine@lfdr.de>; Tue, 23 Mar 2021 12:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbhCWL4H (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 23 Mar 2021 07:56:07 -0400
Received: from mail-dm6nam12on2075.outbound.protection.outlook.com ([40.107.243.75]:30913
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230189AbhCWL4D (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 23 Mar 2021 07:56:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J8zZ0CZVHY+R7SgDi18SZndPWD0EQZ+zH40j26dklN6V4tJw63A4gZOMuQxbOCO4Hr2zIuDFBIUQzGjapf6sqj4e2XgmLLPbeP9ToLnUu8iblmu7OmivGrsZVn61VWhbY/NjvaEHxYviQQ0yW/AOW5ejIKTO1Fw0hN/kOpDbr3x+8wtztW4LvdsqxJyAdoAV3MxN68NQIyPsSM01S92kAy3eeAPXbx2uvr2VD342a9+ChCTqU48aKHdvDyY4VZPjhekp95hiDDPWOEcizp6rDZJnbA6VGOHItAiM94qcA94ECIXwm7KRrGmhaU9cGw8VTiplh1RMjL3xGlHvfypzmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZNJLhs30Vg5fUrMZL/5w+urY3pGofJB/+q4aJhITdc=;
 b=X4955qi/PxUVxY/jQ1lEar7KVXCr/vm7I+K4Ic4xoDyHBybHwfy2zH+xf0W3f5wyhITKrP6XPfHhRlfSPi4tWflauq+JWrvR84XWzsNimVpV6aPZbrjbbq0zWpeOCnrZ5cm/hrAqqKfiQiIqUXQg00BlKl6BzmuCZS2YM1Cvk0eIYl5Ltpk7E+HfD4cmD4k6JfDqz6viHwTRNl8xnxkPmrG3NywFc1s/ZykW6+GjRSoNLZYHBjrYwxbSZnbXgLY/ViZXmxR7MPHfv6cHhb5ZFxrC4e6ffQUG3exUyWJRB/RUSzyTHTDORa7HQOBfFW4PcPYaYnukuj5NCeNK768knw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZNJLhs30Vg5fUrMZL/5w+urY3pGofJB/+q4aJhITdc=;
 b=F6BqV7/aDUmV3vpt7NWZSJ70gyRIeyei/NZNmuFVKYUqrxlCXgKLOVMgzdYAZ9GdP5jqsWHLbQZNxHjmqoq1DHHkWbYKKhc5voUhvKzSCsoCneWbnSs5bjSMM4tTz7+3YLn2ERh2YcWKq5I+z65IgstIswuawY8vz5sqC3whKZ7R7s8bV0BifDe5FYM0YO3NLGY3ppuGitlwzjjD1nZ5ggaeU1GOBoBv8fj+oFoy6MZyt7PkyNpGvc6pJSy5JwAeawXj+QZvoNcACczJyH3M7OXyDZFgQzw172c7qYkKLqLaDRwHoY8r0c80GjMwAkCxEDJvZrHvJmV+59UtFugLmA==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1243.namprd12.prod.outlook.com (2603:10b6:3:74::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Tue, 23 Mar
 2021 11:56:01 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3955.027; Tue, 23 Mar 2021
 11:56:01 +0000
Date:   Tue, 23 Mar 2021 08:56:00 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH v7 0/8] idxd 'struct device' lifetime handling fixes
Message-ID: <20210323115600.GA2356281@nvidia.com>
References: <161645534083.2002542.11583610276394664799.stgit@djiang5-desk3.ch.intel.com>
 <YFnU2oqNavQEsmNZ@vkoul-mobl.Dlink>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFnU2oqNavQEsmNZ@vkoul-mobl.Dlink>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: YTXPR0101CA0028.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::41) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YTXPR0101CA0028.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.24 via Frontend Transport; Tue, 23 Mar 2021 11:56:01 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lOfdg-001Tyd-1G; Tue, 23 Mar 2021 08:56:00 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98b5a3cf-74a5-405f-34b3-08d8edf2a127
X-MS-TrafficTypeDiagnostic: DM5PR12MB1243:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1243E83720C847F147E21EACC2649@DM5PR12MB1243.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gSt81SQygltqNPztKhsVMYMGsW9gaSEHHXnrmSyonux8UMeIXKUvW1NDaRKnZCFNTs1inutBJP87K6Fga3urCoowTRBsk35cXsnq7iOwYol0/Beer8NK4qY0c/vXSyHtWHgSZ8FKcJzZ56HaV2cV4zIq4XqnnfkUsr3r7uoI03OTMU4qe03io+qnAQ+wTJnDsD3Ij16jdj9XCQ2dkG2Q4RrFSACDSEFC4At0UTI71w1lbx2MWbTp0wWGBbi6uohOEeqaHC56HEzFm7LIwjBbWG6lvgnegqyUYGG4l7wPnLVySZAzN+FBxoFuxnqWs2itIJ470vzVeANe4P2qz1vgQybFj8SJBfrSn1xfWSGLhdrDLGuPXX/nnrfJNYYVISUz+D2at9+nA7nyU697oowd98uDAgJgnM6EbyBcfMhHwmlLyKV7NP4ggvUzZKkdYtb+ss/xG6ywTnVEprTWiO6aLzyqaUxGVvYmOfyVOX1Dq8Vvi7UckEUqu/4V7ILnTeiLi7YKTZM7UaiacAav81gBGSGnJHH8CRAN+1KVIR+bxfxS+dWNIhbydtMjfq+zwHS0ej+yATl2zV0r0yBoW2By5tGRnJedBkO08jhetZVCy0avBVLxLuLsck8Rgj6q3DNqsotj0mY50MiXs5vAoKOKAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(366004)(136003)(39860400002)(6916009)(8676002)(36756003)(5660300002)(426003)(26005)(186003)(8936002)(38100700001)(54906003)(9786002)(9746002)(66476007)(1076003)(2616005)(66946007)(4326008)(2906002)(83380400001)(53546011)(478600001)(66556008)(33656002)(86362001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?euEIeT4Z+UrD9k2RBN+dr2HyKMpoUXsxVaHS00MIur1fM5/LSKA02TiP52bv?=
 =?us-ascii?Q?/X/L4TbQQcB7fLIj/voC33qAli5fHYjRIyrjxmTsRXb0coPy+kRE4KnhDCOA?=
 =?us-ascii?Q?5LY6G5/ElZKsOwgk5jh9xUMdF5CNfDCQr61Xq3w0p0uuDtzisx48NSVMe/HF?=
 =?us-ascii?Q?W9x/poxpb43s8jNUlLrEUqOfVILaQbONRxv/qqBf2ahELQ3Jixkc/hX8nDmd?=
 =?us-ascii?Q?+HN1jzCvAmJni1byKE0JWAqJD2Do1mqVsSlhz+yO8zrBH+GeIRjH5T9s5lMc?=
 =?us-ascii?Q?NsDP4LHh1Zi1bEXCjty3/UgkSaF6h9ioiF6xDsXvYmz6I1uTH/oxFQ3Q9g6G?=
 =?us-ascii?Q?bY6HRkpbX0zx4tMwV72Vhi6Xqdqt1n8BrqXzHzpU0DSLeyEauHsnxj84w1xT?=
 =?us-ascii?Q?17QwB2vZ1SUkdL/X6EAlOd5MFbpTuN7d0oS3ODO6PvpkdfAV0quxjsqzSXpV?=
 =?us-ascii?Q?0Mk9uc6ueneGkhvWTwINhvbIH1yqpQQ06GHa8CMcjLqSmpUN79Mp7ie4UP5z?=
 =?us-ascii?Q?q0DYNZ43YPiFhjnc4yvTd0gHoPM4TzbGjJedHyltvF9z7B1aJW0Z91DMhp+Z?=
 =?us-ascii?Q?KBypF713bJIUhVAaL8YFwlI36q1w4kIMXMhOKlCL1ukItGzjvV4NS4l9oWbY?=
 =?us-ascii?Q?ymKCCJrWIJewTLGgAcxQjrnab69GFMaxJb1Fsf6mp0REdKAClDbjFrXDF1Wz?=
 =?us-ascii?Q?pP7G3pe/PiblKxIEkxvkAihEIwVuao6/TJJbtAFr57N0rbQShe4wYDNoxIEy?=
 =?us-ascii?Q?QzpoKZl2viHpS/QZssQPAHbPWS7GM/xCVioIyymd4M3BEdbeV5kBwrl2VCrh?=
 =?us-ascii?Q?MPUXdLSJmSfQKPUHzVqSwdcMXTEpnoWlNKUTvTugF2TEbPXPeCIwRzm6Ihzq?=
 =?us-ascii?Q?3ZTIUomrE48gvfFdhYYUikC+zXZF7AIZGwnfeLlWW+p6LtpiY+qaMJd0Kzk/?=
 =?us-ascii?Q?4dnGOqXlI90lzQ4kXu1F76w/HEpww/j+EKxo0KM1GKvi/ZQhSKatIc2UFFwM?=
 =?us-ascii?Q?J1xvmoKgNdcHbwT045ZYi8F1IZc3HJif4i75h+e64GOKFoYdYj9hHjbprKid?=
 =?us-ascii?Q?bQTe+ML1qMsl2VAQmk0iCpN8nmOktR/TB6OBPbA0omYyseGk7XZ9/gyanI6J?=
 =?us-ascii?Q?MIgV9nmJywg1V1wIikIPJ8hWWKDwJq5NgjDZeGMtWa1CPLWbZ6F6JGd+FdId?=
 =?us-ascii?Q?NCdWBmUZa6ehF9GBOYKPBfL0wHkbMfkl/dfIFlXnZmYQAOZhc/Z8wgDSM1za?=
 =?us-ascii?Q?FQCdP+FZTuVBRRRax35r7rczh3ZixP9VpKt5wrWHUGWy8vnR6Udw/5zQdmu2?=
 =?us-ascii?Q?mRYBgem05AB6O+Qf0JjcE8OW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b5a3cf-74a5-405f-34b3-08d8edf2a127
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2021 11:56:01.5764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uytz6vjQkt1RhuLxIS4j+X6GlTLOEhzVhxhbWYYmXvvQQNKQQie5CdME2baV80u5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1243
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Mar 23, 2021 at 05:15:30PM +0530, Vinod Koul wrote:
> Hi Dave,
> 
> On 22-03-21, 16:31, Dave Jiang wrote:
> > v7:
> > - Fix up the 'struct device' setup in char device code (Jason)
> > - Split out the char dev fixes (Jason)
> > - Split out the DMA dev fixes (Dan)
> > - Split out the each of the conf_dev fixes
> > - Split out removal of the pcim_* calls
> > - Split out removal of the devm_* calls
> > - Split out the fixes for interrupt config calls
> > - Reviewed by Dan.
> > 
> > v6:
> > - Fix char dev initialization issues (Jason)
> > - Fix other 'struct device' initialization issues.
> > 
> > v5:
> > - Rebased against 5.12-rc dmaengine/fixes
> > v4:
> > - fix up the life time of cdev creation/destruction (Jason)
> > - Tested with KASAN and other memory allocation leak detections. (Jason)
> > 
> > v3:
> > - Remove devm_* for irq request and cleanup related bits (Jason)
> > v2:
> > - Remove all devm_* alloc for idxd_device (Jason)
> > - Add kref dep for dma_dev (Jason)
> > 
> > Vinod,
> > The series fixes the various 'struct device' lifetime handling in the
> > idxd driver. The devm managed lifetime is incompatible with 'struct device'
> > objects that resides in the idxd context. Tested with
> > CONFIG_DEBUG_KOBJECT_RELEASE and address all issues from that.
> 
> Sorry for not looking into this earlier.. But I would like to check on
> the direction idxd is taking. Somehow I get the feel the dmaengine is
> not the right place for this. Considering that now we have auxdev merged
> in, should the idxd be spilt into smaller function and no dmaengine
> parts moved away from dmaengine... I think we do lack a subsystem for
> all things accelerator in kernel atm...

auxdev shouldn't be over-used IMHO.

If the main purpose of the driver is dma engine then it is OK if the
"core" part lives there too.

Jason
