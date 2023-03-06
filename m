Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A732B6ACAF8
	for <lists+dmaengine@lfdr.de>; Mon,  6 Mar 2023 18:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjCFRo5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Mar 2023 12:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjCFRoo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Mar 2023 12:44:44 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on20629.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8c::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B813C40FB;
        Mon,  6 Mar 2023 09:44:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mE2Rf7sx6qYIEqUdcs2tqAMYHOETVKEBQGYl52Q7z1xI6icjLlBiyqIXKB7so0q2JgVktOp02yjXmf+RLhko8J19m6b8ZjKFWfvbwVgXL/2VNGAccCk2oI3b1A31SRSnXTQbDpMJuMELd5rEyNHINGXv+oKjqEn1V0y3OOflMgyqLtyv7y6ShwnMJU0MKF565z6q4lAjBl9/HX3LjPGc0cTd3UvrQD4xQIFujOop7q9jRknphroNEWGfm9BHJisMV+NmaHEXFIIcH4xJmJ5qR7luyVbaNUziRDu6EADNYv2EHBJ5VpsBu0UGy1mpb1MKg84gm1PwkSRI8Gdm2YhJOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x89wmjrNfloOWiCxlzvwelZUTg6UKjUJjao/NaEfGs4=;
 b=SA/EuAkoQwztpX5ZX00kxaLbmGMuJjrqx9dCVPvlBCv7mWmW1GEtPJDd9/hV1qoK+luztssvTgnpwr3TseXfEf6i3n9g7G4vWZvIWPw6YP7r1GkT1aH02YRx1VqfI/+7bv2e7fYmjSuqy3ZcXzj2jn39S7zfEo0aHZwrqcXnKJ0kCs4WtKwii7DJAgPqWMqpEdY8KS9VCyaexlmg7HE089lHbZDkFavd/wZkzbLw/VD8q/+9pxW0wz+y+fwlOzBNqjnru54UN+SST4eUBwRw1pXOOk2Ae8G0C+QBME/t5ERP8cmRBWF/61INaOZQMXxD5Dc2+VWWTjge390b8cENpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x89wmjrNfloOWiCxlzvwelZUTg6UKjUJjao/NaEfGs4=;
 b=S2utnSz0AORglN0oPV8BjVaDQiyKn4DRHmKSGcc4DazJlJUtXr4fzqnWvy6kmjHAOTYVFZBA4kaG9amOCUNoguU3pFD5hHV/QoWwgodhbcS156UkGpYog8uUugNOozuXzoMkaI8N9T8ttKMyp1N+v/wqqFY5HW7n3rDFNjL/eLX+GYW6LQzDkVyHd38iGetOfXkwpDP6dZ0ChY2rW+xdXHNTM6hTPu0hdEH/LDRD74BCiHWDEWmHZ+1CQT20E3oEDsAC+I03iS1Aytq3xtWh67oWI9TBkIEJCSvD3CyHb/MYQjmptEtplYUgygvke+Zeh4dnd5xX5p6aaDK3yI4Rgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB8595.namprd12.prod.outlook.com (2603:10b6:510:1b5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.27; Mon, 6 Mar
 2023 17:43:41 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6156.027; Mon, 6 Mar 2023
 17:43:41 +0000
Date:   Mon, 6 Mar 2023 13:43:39 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>
Subject: Re: [PATCH 3/4] iommu/sva: Support reservation of global PASIDs
Message-ID: <ZAYmS4Sx6bm+ziDY@nvidia.com>
References: <20230302005959.2695267-1-jacob.jun.pan@linux.intel.com>
 <20230302005959.2695267-4-jacob.jun.pan@linux.intel.com>
 <BN9PR11MB52765C5E0DC0759880C08E258CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20230303134753.660d0755@jacob-builder>
 <ZAXkLN39VUSl+t65@nvidia.com>
 <20230306094408.2d675d5b@jacob-builder>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306094408.2d675d5b@jacob-builder>
X-ClientProxiedBy: MN2PR01CA0039.prod.exchangelabs.com (2603:10b6:208:23f::8)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB8595:EE_
X-MS-Office365-Filtering-Correlation-Id: e93e8a9e-b182-4344-6a0a-08db1e6a52e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OzSPuVaHjeQY+H6tz2F8XP2ACFLBynqlem7dPusijq0O1lfzMYf2Lt/Gt6DeCPY+Ztl3WMM7YlPlU224dhfpJEsuv0Zj433UijuflzC5c7ZoY7rsjEfwdEamyXU9QlXeWu/ZV6hMlmFoojK3GNA+s6cvymhGU1Jbvf1NQ9YSnmE2K/Gvg4rRFUL0ixiPCxuRbml9KU0vvY8RA5Cp5GQhrrhhlQamj0931QxwFFdLNHASVzDPgPtCROaVUR9PbeclodnAfap9WaqulKHlrhJwE4ranS/rHjFvb5/mXxSGEoutIIlhH/9j6sLILKdc4Tvb6sQv1/VVYjy1qRqbmwFKDsG/eLd/lC/G1A3zJPfUbzprb8KgsIkvgBZAJrUVoN0r8lm6Wxn9fBM2Pp41uxHga8HrWEs0YOxWXSP/lwJj7QlEj7nj/+JwzZSimuWthMSUTynIUYWOwkhKxuowCz5jK9ZWYwFKqJob/2QJqpFdyXncvfTFTEk7FxAIy69qpTnPZk51CC/cd080QvOZ9asudHiLKP7c9zLpLe6LyV67kb1iUXgdgfXVjPvdzXMYZTctx08KK+sMhptzPw+EiHvnR7BNVUXQkO27bqTz+gGw0hs1xGnuWq9XbNnyhmZJYFvq4tRj2nodeCNEVzfPKWx5d0HjFYhJuDwrCNfi/p8SpTos4leOU/bRfxMmR9LGoEyM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(136003)(346002)(396003)(376002)(451199018)(478600001)(83380400001)(36756003)(316002)(38100700002)(54906003)(6512007)(2616005)(26005)(186003)(86362001)(6506007)(6486002)(7416002)(5660300002)(6916009)(66946007)(2906002)(41300700001)(8676002)(4326008)(8936002)(66476007)(66556008)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I9LWuB0rxrL6nX/QLwr2TtpldWjNRE5ZHDobTFezvXB9437gIMO4eLBzvZJy?=
 =?us-ascii?Q?/+yivNk5zMVfS402TjMagsuGP46+OIr01I49sXKHLCp/XAhr6k3MCw2okQDq?=
 =?us-ascii?Q?GBAMBTCVjS2xziyzxcdIQM2Q2n9KqmDrGlI/NLBE7DS58wFN8nlyW1NsMLVg?=
 =?us-ascii?Q?dVGU0eWseRtJBMmQUBQ7rDl59guZG4Slno3YBoPkBvg6yhFOy5NZOp1wSSSR?=
 =?us-ascii?Q?PLjditwE0F+3Q7B/KG5Mj7Fa/nqI2IRYX3F9FZ7xhcoQnVu8qm4M23hsO/CP?=
 =?us-ascii?Q?0LjK+4D8951RGyGW9zfeD4lOxJh/jCEQ3lFgI6cdlm42HoYXMHW/mzytKyXr?=
 =?us-ascii?Q?2y5Fisat+rqcY/2QsiHS+rA2hg6ULD/7ITF1NtwdCiOUNIbtKVEccXVJ4k8J?=
 =?us-ascii?Q?22sMF+uUg6j5XROUupqB+2CpVME0jen+fYJ0jrCmr9YWggoOkw1LdKgLwL54?=
 =?us-ascii?Q?E7D2Rhk/RYhMitDkOmT9gvlKZS38CEpupAG8NV6io35yJgZLGj4M0ok+DmsE?=
 =?us-ascii?Q?FpBPF832XWePnhgNTqxmhJyrDhbnRK6dfHwjZgaeR8Tecdm/19L+/eD0cBpK?=
 =?us-ascii?Q?gaeHutqm9+DZTK9t4WcjyPiOf0MwGHeuuE+5sgI7xJk+JSjVdG4oN5LLdNB8?=
 =?us-ascii?Q?iNrv+jvbafoNwelSKEfUJCMAog117pw4KkZv8Z6rx3vKiGcQRN8mtDYtzws2?=
 =?us-ascii?Q?xXKNmltwF6zypRXPMRdngszecgcW/23cvfW79PmQLJuoqoui/Ka0WXWmK/Ph?=
 =?us-ascii?Q?nsQCcBSlj85vXmNJI69dpeG20pt4pTa4zYR6iFGcR/nzRg8I51BlMhKWg3Nw?=
 =?us-ascii?Q?kHng2Rv+yblCxcdVUZmHmhIPi1pyuE62Op04D62aAPG8cxhFlQgnQlIAV9FL?=
 =?us-ascii?Q?bgiFG1grL2scE/a9SJsSHNee8B8+jO7c8gtpvxZXp7+42vtxbvBolq1gRlY5?=
 =?us-ascii?Q?R5IAyi7wsx50pM7VQZFABrAFvJt5I5sr0ni1x/BeSWMFq99NUq5hoWwlgJYl?=
 =?us-ascii?Q?ujGxpezqp6wVC8UIbjJhxi/S8fzduD7Ia7W8YfAZrO6BuGlF3AKf5zhS0oIq?=
 =?us-ascii?Q?2J+nFoQFlZD3oAcnmBJTgyqLviDOzK9rFR5EY3AzJ8WLFSXyylfiET+PBr63?=
 =?us-ascii?Q?HKBi/0yut6Y3dmlcU61o2kGNpf3taA3wxjZvU9t1d9sy1KxlCJ5AID5sD0Vg?=
 =?us-ascii?Q?r0HYprpood1zDoEnq6v6IUOcMQ3vwT7NheruRoRT+vv1QmXnwRA2tr6d7ZJV?=
 =?us-ascii?Q?Ja3FQGvrxpqCMs/oKFY8nsGXPB7ihsuihDMoGXMsQ8qp9YQBmX4elDfPP+ZM?=
 =?us-ascii?Q?lpu6+AS1cKEorHSN9RdIu7diBUl8pIkJg3ahbYgSHxlwKoiaAJnnidWKqHvP?=
 =?us-ascii?Q?pXxCfioewtjlWNRRHedv3FtQRIj8DXnaePPZrJrrEsZBUhMfYyI4kKba2oIl?=
 =?us-ascii?Q?YRtkdsq0A/2LWljsF1XxfqJG+G3g7MiSAfD9Q0QaoxWc76tXXxYIK5Z5SBL4?=
 =?us-ascii?Q?P1dDUq1vDlE5iZSxk1dQ2jSyXBN4K8yTWo/KkLyosqDQMEabTPiMlGRRSoG+?=
 =?us-ascii?Q?oBffH6OidSip0TwCPxg3KWfMxjjF2z+0xx6SXNQ4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e93e8a9e-b182-4344-6a0a-08db1e6a52e4
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 17:43:41.0530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LMViDqDdy/VmlyDDnjFdgNhU/tiyhvErRsggurai2YuDHUMgKOiHyUqpYsFSoOn8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8595
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Mar 06, 2023 at 09:44:08AM -0800, Jacob Pan wrote:
> Hi Jason,
> 
> On Mon, 6 Mar 2023 09:01:32 -0400, Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > On Fri, Mar 03, 2023 at 01:47:53PM -0800, Jacob Pan wrote:
> > > Hi Kevin,
> > > 
> > > On Thu, 2 Mar 2023 09:43:03 +0000, "Tian, Kevin" <kevin.tian@intel.com>
> > > wrote:
> > >   
> > > > > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > > > Sent: Thursday, March 2, 2023 9:00 AM
> > > > > 
> > > > > Global PASID allocation is under IOMMU SVA code since it is the
> > > > > primary use case.  However, some architecture such as VT-d, global
> > > > > PASIDs are necessary for its internal use of DMA API with PASID.    
> > > > 
> > > > No, global PASID is not a VT-d restriction. It's from ENQCMD/S hence a
> > > > device requirement.  
> > > I meant VT-d based platforms, it is kind of intertwined in that ENQCMDS
> > > does not restrict RIDPASID!=DMA PASID, vt-d does. Without this
> > > restriction, there wouldn't be a need for this patch. Let me reword.  
> > 
> > No, Kevin is right, there is nothing about VT-d that needs global
> > PASID values.
> > 
> > The driver should be managing RID2PASID itself to avoid conflicting
> > with any in-use PASID, either by changing RID2PASID on demand or by
> > setting it to a value that is not part of the PASID number space, eg
> > we can make 0 entirely invalid, or the driver can reduce max_pasid of
> > the devices it controls and use PASID_MAX.
> > 
> I see, thank you both. how about
> "This patch provide an API for device drivers to request global PASIDs as
> needed. The device drivers will then gain the flexibility of choosing
> PASIDs not conflicting with anyone in-use."

Stil no, this functionality should be clearly and unambiguously tied
to ENQCMD:

Devices that rely on Intel ENQCMD have a single CPU register to store
the current thread's PASID in. This necessarily makes the PASID a
system-global value shared by all ENQCMD using devices.

This matches the current allocator being used for the SVA PASID so for
now allow ENQCMD drivers to access this PASID allocator for other
uses.

Jason
